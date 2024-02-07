//
//  CollectionCell.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

class CollectionCell<Model: CellIdentifiable>: UICollectionViewCell {
    private(set) var model: Model?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: Model) {
        self.model = model
    }

    func setupUI() {}
}
