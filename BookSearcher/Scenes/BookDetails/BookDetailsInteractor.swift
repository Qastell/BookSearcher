//
//  BookDetailsInteractor.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

protocol BookDetailsInteractorProtocol {
    func getBookObject() -> BookObject
}

final class BookDetailsInteractor {
    
    private let bookObject: BookObject
    
    init(bookObject: BookObject) {
        self.bookObject = bookObject
    }
    
}

// MARK: - BookDetailsPresenterProtocol

extension BookDetailsInteractor: BookDetailsInteractorProtocol {
    func getBookObject() -> BookObject {
        return bookObject
    }
}

// MARK: - Private

private extension BookDetailsInteractor {}
