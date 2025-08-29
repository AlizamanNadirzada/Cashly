//
//  AppCoordinator.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 23.08.25.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
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


class AppCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAuthFlow()
    }
    
    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        addChild(authCoordinator)
        authCoordinator.start()
        
        authCoordinator.onAuthSuccess = { [weak self, weak authCoordinator] in
            guard let self = self, let authCoordinator = authCoordinator else { return }
            self.removeChild(authCoordinator)
            self.showMainFlow()
        }
    }
    
    private func showMainFlow() {
        let mainVC = UIViewController()
        mainVC.view.backgroundColor = .systemGreen
        mainVC.title = "Main Screen"
        navigationController.setViewControllers([mainVC], animated: true)
    }
}
