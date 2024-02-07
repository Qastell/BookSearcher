//
//  SearchSectionHeaderView.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit
import Stevia

final class SearchSectionHeaderView: UICollectionReusableView {
    private let textContainerView = UIView()
        .backgroundColor(App.colors.backgroundSecondary)

    private let titleLabel = UILabel()
        .font(App.fonts.semibold(of: 12))
        .textColor(App.colors.textPrimary)
        .text(App.strings.searchBooksHeaderTitle)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textContainerView.cornerRadius = textContainerView.bounds.height / 2
    }
}

extension SearchSectionHeaderView {
    private func setupUI() {
        subviews(
            textContainerView.subviews(
                titleLabel
            )
        )

        textContainerView
            .fillVertically(padding: 8)
            .centerHorizontally()

        titleLabel
            .fillVertically(padding: 2)
            .fillHorizontally(padding: 4)
    }
}

