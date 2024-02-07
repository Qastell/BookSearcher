//
//  SearchResponseEntity.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

struct SearchResponseEntity: Codable {
    let totalItems: Int
    let items: [SearchItemResponseEntity]
}
