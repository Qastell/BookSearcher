//
//  NetworkService.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

class NetworkService {
    private let urlSession = URLSession(configuration: .default)
    
    func execute<T: Codable>(request: URLRequest?) async throws -> T {
        guard let request else {
            throw BSError.requestError
        }
        
        let (data, _) = try await urlSession.data(for: request)
        
        if let string = String(data: data, encoding: .utf8), let url = request.url {
            print("[DATA] - \(url) - ", string)
        }
        
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch let jsonError {
            throw jsonError
        }
    }
}
