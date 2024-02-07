//
//  StackView+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit.UIStackView

extension UIStackView {
    @discardableResult
    func axis(_ value: NSLayoutConstraint.Axis) -> Self {
        axis = value
        return self
    }

    @discardableResult
    func spacing(_ value: CGFloat) -> Self {
        spacing = value
        return self
    }
}
