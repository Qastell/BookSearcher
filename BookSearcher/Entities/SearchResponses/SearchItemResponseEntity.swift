//
//  SearchItemResponseEntity.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import Foundation

struct SearchItemResponseEntity: Codable {
    let id: String
    let volumeInfo: SearchVolumeInfoResponseEntity?
}
