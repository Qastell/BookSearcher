//
//  SearchPresenter.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

protocol SearchPresenterProtocol: Presenter {
    func didSelectItem(at indexPath: IndexPath)
    func didChangeSearchText(_ searchText: String?)
}

final class SearchPresenter {
    
    private weak var view: SearchViewControllerProtocol?
    private let router: SearchRouterProtocol
    private let interactor: SearchInteractorProtocol
    
    private let minSearchTextLenghtToSearch: Int = 3
    private var section: SearchSection?
    
    init(view: SearchViewControllerProtocol,
         router: SearchRouterProtocol,
         interactor: SearchInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SearchPresenterProtocol

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad() {
        loadStoredContent()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let section,
              let model = section.items[safe: indexPath.item],
              let object = interactor.getBookObject(with: model.id,
                                                    fromStore: section.kind == .stored) else {
            return
        }
        
        router.showBookDetails(with: object)
    }
    
    func didChangeSearchText(_ searchText: String?) {
        Task {
            guard let searchText, searchText.count >= minSearchTextLenghtToSearch else {
                interactor.cancelSearch()
                loadStoredContent()
                return
            }
            
            let booksResponse = await interactor.searchBooks(searchText: searchText)
            section = createSection(entities: booksResponse?.items)
            await view?.applySnapshot(section: section, animated: true)
        }
    }
}

// MARK: - Private

private extension SearchPresenter {
    func loadStoredContent() {
        interactor.fetchStoredBooks { [weak self] bookObjects in
            guard let self else { return }
            
            Task {
                self.section = self.createSection(objects: bookObjects)
                await self.view?.applySnapshot(section: self.section, animated: true)
            }
        }
    }
    
    func createSection(entities: [SearchItemResponseEntity]?) -> SearchSection? {
        guard let entities else {
            return nil
        }
        
        let items = entities.map {
            return SearchCellModel(id: $0.id,
                                   title: $0.volumeInfo?.title,
                                   authorsTitle: $0.volumeInfo?.authors?.joined(separator: ", "))
        }.removeDuplicates()
        return SearchSection(kind: .loaded, items: items)
    }
    
    func createSection(objects: [BookObject]?) -> SearchSection? {
        guard let objects else {
            return nil
        }
        
        let items = objects.map {
            return SearchCellModel(id: $0.id,
                                   title: $0.title,
                                   authorsTitle: $0.authors)
        }.removeDuplicates()
        return SearchSection(kind: .stored, items: items)
    }
}
