//
//  App.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

enum App {}

// MARK: - strings

extension App {
    enum strings {
        static var searchBooksPlaceholder: String { "Поиск по книгам" }
        static var searchBooksHeaderTitle: String { "Искали ранее" }
    }
}

// MARK: - colors

extension App {
    enum colors {
        static var background: UIColor { UIColor.color(named: "background") }
        static var backgroundSecondary: UIColor { UIColor.color(named: "backgroundSecondary") }
        static var textPrimary: UIColor { UIColor.color(named: "textPrimary") }
    }
}

// MARK: - fonts

extension App {
    enum fonts {
        static func regular(of size: CGFloat) -> UIFont {
            return .systemFont(ofSize: size, weight: .regular)
        }

        static func medium(of size: CGFloat) -> UIFont {
            return .systemFont(ofSize: size, weight: .medium)
        }

        static func semibold(of size: CGFloat) -> UIFont {
            return .systemFont(ofSize: size, weight: .semibold)
        }

        static func bold(of size: CGFloat) -> UIFont {
            return .systemFont(ofSize: size, weight: .bold)
        }
    }
}
