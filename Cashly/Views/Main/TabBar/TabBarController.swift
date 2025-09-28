//
//  TabBarController.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 18.09.25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .base01
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .systemBackground
        
        // MARK: - ViewControllers
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle"),
            tag: 1
        )
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        viewControllers = [homeNav, profileNav]
    }
}
