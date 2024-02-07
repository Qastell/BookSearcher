//
//  SearchSection.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

struct SearchSection: Hashable {
    let kind: Kind
    let items: [SearchCellModel]
}

extension SearchSection {
    enum Kind {
        case stored
        case loaded
    }
}
