//
//  SearchBuilder.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

enum SearchBuilder {
    static func create() -> UIViewController {
        let view = SearchViewController()
        let router = SearchRouter(viewController: view)
        let interactor = SearchInteractor(bookService: DI.container.bookService, 
                                          bookStorageService: DI.container.bookStorageService)
        let presenter = SearchPresenter(view: view,
                                             router: router,
                                             interactor: interactor)
        view.presenter = presenter
        return view
    }
}
