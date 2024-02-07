//
//  RequestBuilder.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

enum RequestBuilder {
    static func build(components: RequestComponents) -> URLRequest? {
        let queryItems: [URLQueryItem] = components.query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var urlComponents = URLComponents(string: components.url)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: resultURL)
        request.httpMethod = components.httpMethod.rawValue
        return request
    }
}
