//
//  Router.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

class Router {
    let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func present(_ controller: UIViewController, presentingController: UIViewController? = nil, animated: Bool = true) {
        (presentingController ?? viewController).present(controller, animated: animated)
    }

    func push(_ controller: UIViewController, animated: Bool = true) {
        viewController.navigationController?.pushViewController(controller, animated: animated)
    }
}
