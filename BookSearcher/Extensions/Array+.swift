//
//  Array+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

extension Array {
    subscript (safe index: Index) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    public func removeDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}
