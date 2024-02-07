//
//  SearchCell.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit
import Stevia

final class SearchCell: CollectionCell<SearchCellModel> {
    
    private let containerView = UIView().backgroundColor(App.colors.backgroundSecondary)
    
    private let titleLabel = UILabel()
        .font(App.fonts.bold(of: 16))
        .textColor(App.colors.textPrimary)
    
    private let authorsLabel = UILabel()
        .font(App.fonts.regular(of: 14))
        .textColor(App.colors.textPrimary)
    
    private lazy var textStackView = UIStackView(arrangedSubviews: [titleLabel, authorsLabel]).axis(.vertical).spacing(2)

    override func configure(with model: SearchCellModel) {
        super.configure(with: model)
        
        titleLabel.text(model.title)
        authorsLabel.text(model.authorsTitle)
        authorsLabel.isHidden = model.authorsTitle.isNilOrEmpty
    }

    override func setupUI() {
        contentView.subviews(
            containerView.subviews(
                textStackView
            )
        )
        
        containerView
            .fillVertically(padding: 2)
            .fillHorizontally(padding: 10)
        
        textStackView
            .centerVertically()
            .fillHorizontally(padding: 16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.cornerRadius = 10
    }
}
