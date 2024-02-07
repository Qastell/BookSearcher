//
//  SearchInteractor.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

protocol SearchInteractorProtocol {
    func fetchStoredBooks(completion: @escaping DataClosure<[BookObject]?>)
    func searchBooks(searchText: String) async -> SearchResponseEntity?
    func cancelSearch()
    func getBookObject(with id: String, fromStore: Bool) -> BookObject?
}

final class SearchInteractor {
    
    private let bookService: BookServiceProtocol
    private let bookStorageService: any BookStorageServiceProtocol
    private let trottler = ThrottlerWorker<SearchResponseEntity?>()
    
    private var cachedEntities: [SearchItemResponseEntity]?
    private var cachedObjects: [BookObject]?
    private var needsLoadFreshObjects = true
    
    init(bookService: BookServiceProtocol,
         bookStorageService: any BookStorageServiceProtocol) {
        self.bookService = bookService
        self.bookStorageService = bookStorageService
    }
}

// MARK: - SearchPresenterProtocol

extension SearchInteractor: SearchInteractorProtocol {
    func fetchStoredBooks(completion: @escaping DataClosure<[BookObject]?>) {
        guard needsLoadFreshObjects else {
            completion(cachedObjects)
            return
        }
        needsLoadFreshObjects = false
        
        let sortDescriptor = NSSortDescriptor(key: "refreshingDate", ascending: false)
        let parameters = CoreDataFetchParameters(sortDescriptors: [sortDescriptor])
        bookStorageService.fetchAll(fetchConfiguration: parameters) { [weak self] objects in
            self?.cachedObjects = objects
            completion(objects)
        }
    }
    
    func cancelSearch() {
        trottler.cancel()
    }
    
    func searchBooks(searchText: String) async -> SearchResponseEntity? {
        return try? await trottler.throttle(delayInterval: 0.3) { [weak self] in
            do {
                let entity = try await self?.bookService.searchBooks(with: searchText)
                self?.cachedEntities = entity?.items
                return entity
            } catch {
                mark(error)
                return nil
            }
        }?.value
    }
    
    func getBookObject(with id: String, fromStore: Bool) -> BookObject? {
        if fromStore {
            return cachedObjects?.first(where: { $0.id == id })
        } else {
            guard let entity = cachedEntities?.first(where: { $0.id == id }) else {
                return nil
            }
            
            needsLoadFreshObjects = true
            guard let object = bookStorageService.createObject(configurationHandler: { object in
                object.id = entity.id
                object.authors = entity.volumeInfo?.authors?.joined(separator: ", ")
                object.year = entity.volumeInfo?.publishedDate
                object.imagePath = entity.volumeInfo?.imageLinks?.thumbnail
                object.title = entity.volumeInfo?.title
                object.refreshingDate = Date()
            }) else {
                return nil
            }
            
            if let index = cachedObjects?.firstIndex(where: { $0.id == object.id }) {
                cachedObjects?.remove(at: index)
            }
            cachedObjects?.insert(object, at: 0)
            return object
        }
    }
}

// MARK: - Private

private extension SearchInteractor {}
