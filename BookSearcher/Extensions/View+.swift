//
//  View+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit.UIView

extension UIView {
    func hideKeyboardWhenTapped() {
        let view = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(view, at: 0)
        view.fillContainer()
    }

    @objc
    func hideKeyboard() {
        (superview ?? self).endEditing(true)
    }

    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }

    @discardableResult
    func isHidden(_ value: Bool) -> Self {
        isHidden = value
        return self
    }

    @discardableResult
    func backgroundColor(_ value: UIColor) -> Self {
        backgroundColor = value
        return self
    }

    @discardableResult
    func tintColor(_ value: UIColor) -> Self {
        tintColor = value
        return self
    }

    @discardableResult
    func contentMode(_ value: UIView.ContentMode) -> Self {
        contentMode = value
        return self
    }
}
