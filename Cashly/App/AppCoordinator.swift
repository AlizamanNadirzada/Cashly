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
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        showAuthFlow()
    }
    
    private func showAuthFlow() {
        let navigationController = UINavigationController()
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


    func showTabBar() {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.tintColor = .button01
        tabBarVC.tabBar.unselectedItemTintColor = .gray


        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let transferVC = UIViewController()
        transferVC.tabBarItem = UITabBarItem(title: "Transfer", image: UIImage(systemName: "person.crop.circle"), tag: 1)

        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "gear"), tag: 2)

        let home = UINavigationController(rootViewController: homeVC)
        let transfer = UINavigationController(rootViewController: transferVC)
        let profile = UINavigationController(rootViewController: profileVC)

        tabBarVC.viewControllers = [home, transfer, profile]

        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
    }
}
