//
//  SearchVolumeInfoResponseEntity.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

struct SearchVolumeInfoResponseEntity: Codable {
    let title: String?
    let authors: [String]?
    let publishedDate: String?
    let imageLinks: SearchImageLinksResponseEntity?
}
