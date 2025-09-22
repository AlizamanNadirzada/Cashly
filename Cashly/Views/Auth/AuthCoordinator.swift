//
//  AuthCoordinator.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 28.08.25.
//

import UIKit

final class AuthCoordinator: Coordinator {
    var children: [Coordinator] = []

    private let navigationController: UINavigationController

    var onAuthSuccess: (() -> Void)?

    private let userRepository: UserRepository
    private let loginUserUseCase: LoginUserUseCase
    private let registerUserUseCase: RegisterUserUseCase

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        let dataSource = UserLocalDatasource()
        let repositoryImpl = UserRepositoryImpl(localDatasource: dataSource)

        self.userRepository = repositoryImpl
        self.loginUserUseCase = LoginUserUseCase(repository: repositoryImpl)
        self.registerUserUseCase = RegisterUserUseCase(repository: repositoryImpl)
    }

    func start() {
        showLogin()
    }

    func showLogin() {
        let viewModel = LoginViewModel(coordinator: self, loginUseCase: loginUserUseCase)
        let controller = LoginViewController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: true)
    }
}

extension AuthCoordinator: AuthProtocol {
    func showRegister() {
        let viewModel = RegisterViewModel(coordinator: self, registerUseCase: registerUserUseCase)
        let controller = RegisterViewController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: true)
    }

    func showTabBar() {
        onAuthSuccess?()
    }
}
