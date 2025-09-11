//
//  AuthCoordinator.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 28.08.25.
//

import UIKit

protocol AuthCoordinatorProtocol: AnyObject {
    func showRegister()
    func showLogin()
    func showTabBar()
}

final class AuthCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var onAuthSuccess: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showScreen()
    }
    
    func showScreen() {
        let loginVC = LoginViewController(viewModel: LoginViewModel(coordinator: self))
        navigationController.setViewControllers([loginVC], animated: false)
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func showRegister() {
        let registerVC = RegisterViewController(viewModel: RegisterViewModel(coordinator: self))
        navigationController.setViewControllers([registerVC], animated: true)
    }
    
    func showLogin() {
        let loginVC = LoginViewController(viewModel: LoginViewModel(coordinator: self))
        navigationController.setViewControllers([loginVC], animated: true)
    }
    
    func showTabBar() {
        onAuthSuccess?()
    }
}
