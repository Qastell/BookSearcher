//
//  BookDetailsViewController.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit
import Stevia

protocol BookDetailsViewControllerProtocol: AnyObject {
    func configure(title: String?, authorTitle: String?, yearTitle: String?, imagePath: String?) 
}

final class BookDetailsViewController: ViewController {
    
    var presenter: BookDetailsPresenterProtocol?
    
    // MARK: - Private props
    
    // MARK: - UI
    
    private let scrollView = UIScrollView()
    private lazy var stackView = UIStackView(arrangedSubviews: [imageView, textStackView])
        .axis(.vertical)
        .spacing(24)
    
    private lazy var textStackView = UIStackView(arrangedSubviews: [titleLabel, authorsLabel, yearLabel])
        .axis(.vertical)
        .spacing(16)
    
    private let imageView = UIImageView()
        .contentMode(.scaleAspectFit)
    
    private let titleLabel = UILabel()
        .font(App.fonts.bold(of: 24))
        .textColor(App.colors.textPrimary)
        .textAlignment(.center)
        .numberOfLines(0)
    
    private let authorsLabel = UILabel()
        .font(App.fonts.regular(of: 20))
        .textColor(App.colors.textPrimary)
        .textAlignment(.center)
        .numberOfLines(0)
    
    private let yearLabel = UILabel()
        .font(App.fonts.regular(of: 14))
        .textColor(App.colors.textPrimary)
        .textAlignment(.center)
        .numberOfLines(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func setupUI() {
        view.backgroundColor = App.colors.background
        view.subviews(
            scrollView.subviews(
                stackView
            )
        )
        
        imageView
            .height(300)
        
        stackView
            .fillContainer()
            .Width == view.Width
        
        scrollView
            .fillContainer()
    }
}

// MARK: - BookDetailsViewControllerProtocol

extension BookDetailsViewController: BookDetailsViewControllerProtocol {
    func configure(title: String?, authorTitle: String?, yearTitle: String?, imagePath: String?) {
        imageView.setImage(imagePath)
        imageView.isHidden = imagePath.isNilOrEmpty
        titleLabel.setTextOrHide(title)
        authorsLabel.setTextOrHide(authorTitle)
        yearLabel.setTextOrHide(yearTitle)
    }
}

// MARK: - Private

private extension BookDetailsViewController {}

