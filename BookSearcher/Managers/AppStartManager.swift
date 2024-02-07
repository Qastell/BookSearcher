//
//  AppStartManager.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

protocol AppStartManagerProtocol {
    func start(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
}

final class AppStartManager: AppStartManagerProtocol {
    private let appWindow = UIWindow(frame: UIScreen.main.bounds)
}

extension AppStartManager {
    func start(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let searchModule = SearchBuilder.create()
        let navigationController = UINavigationController(rootViewController: searchModule)
        appWindow.rootViewController = navigationController
        appWindow.makeKeyAndVisible()
        return true
    }
}
