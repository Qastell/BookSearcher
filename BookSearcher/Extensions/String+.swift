//
//  String+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        if let self, self.isEmpty == false {
            return self
        } else {
            return nil
        }
    }

    var isNilOrEmpty: Bool {
        return nilIfEmpty == nil
    }
}
