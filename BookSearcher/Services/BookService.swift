//
//  BookService.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

protocol BookServiceProtocol {
    func searchBooks(with searchText: String) async throws -> SearchResponseEntity
}

final class BookService: NetworkService {}

extension BookService: BookServiceProtocol {
    func searchBooks(with searchText: String) async throws -> SearchResponseEntity {
        let requestComponents = RequestComponents(url: "https://www.googleapis.com/books/v1/volumes",
                                                  query: ["q": searchText],
                                                  httpMethod: .get)
        let request = RequestBuilder.build(components: requestComponents)
        return try await execute(request: request)
    }
}
