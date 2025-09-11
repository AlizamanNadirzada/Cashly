//
//  TabBarCoordinator.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 01.09.25.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var children: [Coordinator] = []
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let tabBarVC = UITabBarController()

        // Home VC
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        // Profile VC
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)

        // NavigationController ilə wrap et
        let homeNav = UINavigationController(rootViewController: homeVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        tabBarVC.viewControllers = [homeNav, profileNav]

        // Root olaraq set et
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
    }
}
