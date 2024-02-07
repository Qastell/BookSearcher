//
//  SearchRouter.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

protocol SearchRouterProtocol {
    func showBookDetails(with bookObject: BookObject)
}

final class SearchRouter: Router {}

// MARK: - SearchRouterProtocol

extension SearchRouter: SearchRouterProtocol {
    func showBookDetails(with bookObject: BookObject) {
        let controller = BookDetailsBuilder.create(bookObject: bookObject)
        push(controller)
    }
}
