//
//  DI.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

final class DI {
    static let container = DI()

    private(set) lazy var bookService: BookServiceProtocol = BookService()
    private(set) lazy var bookStorageService: any BookStorageServiceProtocol = BookStorageService()
    
    private init() {}
}
