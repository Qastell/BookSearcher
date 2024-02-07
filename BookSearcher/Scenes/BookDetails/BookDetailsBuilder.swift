//
//  BookDetailsBuilder.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

enum BookDetailsBuilder {
    static func create(bookObject: BookObject) -> UIViewController {
        let view = BookDetailsViewController()
        let router = BookDetailsRouter(viewController: view)
        let interactor = BookDetailsInteractor(bookObject: bookObject)
        let presenter = BookDetailsPresenter(view: view,
                                             router: router,
                                             interactor: interactor)
        view.presenter = presenter
        return view
    }
}
