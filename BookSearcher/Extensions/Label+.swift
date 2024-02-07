//
//  Label+.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

extension UILabel {
    @discardableResult
    func setTextOrHide(_ value: String?) -> UILabel {
        text = value
        isHidden = value.isNilOrEmpty
        return self
    }
    
    @discardableResult
    func text(_ value: String?) -> UILabel {
        text = value
        return self
    }

    @discardableResult
    func font(_ value: UIFont) -> UILabel {
        font = value
        return self
    }

    @discardableResult
    func textColor(_ value: UIColor) -> UILabel {
        textColor = value
        return self
    }

    @discardableResult
    func textAlignment(_ value: NSTextAlignment) -> UILabel {
        textAlignment = value
        return self
    }

    @discardableResult
    func numberOfLines(_ value: Int) -> UILabel {
        numberOfLines = value
        return self
    }

    @discardableResult
    func adjustsFontSizeToFitWidth(_ value: Bool) -> UILabel {
        adjustsFontSizeToFitWidth = value
        return self
    }
}
