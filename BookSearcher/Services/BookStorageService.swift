//
//  BookStorageService.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

protocol BookStorageServiceProtocol: StorageService where Object: BookObject {}
final class BookStorageService: StorageServiceImplementation<BookObject>, BookStorageServiceProtocol {}
