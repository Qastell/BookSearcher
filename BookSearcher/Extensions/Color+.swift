//
//  Color+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit.UIColor

extension UIColor {
    static func color(named: String) -> UIColor {
        if let color = UIColor(named: named, in: .main, compatibleWith: .current) {
            return color
        }
        mark("Не найден цвет с названием \(named)")
        fatalError()
    }
}
