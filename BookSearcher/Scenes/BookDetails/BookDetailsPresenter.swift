//
//  BookDetailsPresenter.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

protocol BookDetailsPresenterProtocol: Presenter {}

final class BookDetailsPresenter {
    
    private weak var view: BookDetailsViewControllerProtocol?
    private let router: BookDetailsRouterProtocol
    private let interactor: BookDetailsInteractorProtocol
    
    init(view: BookDetailsViewControllerProtocol,
         router: BookDetailsRouterProtocol,
         interactor: BookDetailsInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - BookDetailsPresenterProtocol

extension BookDetailsPresenter: BookDetailsPresenterProtocol {
    func viewDidLoad() {
        let bookObject = interactor.getBookObject()
        view?.configure(title: bookObject.title,
                        authorTitle: bookObject.authors,
                        yearTitle: bookObject.year,
                        imagePath: bookObject.imagePath)
    }
}

// MARK: - Private

private extension BookDetailsPresenter {}
