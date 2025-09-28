//
//  AppCoordinator.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 23.08.25.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinator) {
        children.removeAll { $0 === coordinator }
    }
}

final class AppCoordinator: Coordinator {
    var children: [Coordinator] = []

    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        showAuthFlow()
    }
    
    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        
        authCoordinator.onAuthSuccess = { [weak self, weak authCoordinator] in
            guard let self = self, let authCoordinator = authCoordinator else { return }
            self.removeChild(authCoordinator)
            self.showTabBar()
        }
        
        addChild(authCoordinator)
        authCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showTabBar() {
        let tabBar = TabBarController()
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}
