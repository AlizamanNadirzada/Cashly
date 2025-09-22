//
//  LoginViewModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 25.08.25.
//

import UIKit

final class LoginViewModel {
    private weak var coordinator: AuthCoordinator?
    private let loginUseCase: LoginUserUseCase
    
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(coordinator: AuthCoordinator? = nil, loginUseCase: LoginUserUseCase) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }
    
    func login(email: String, password: String) {
        do {
            let _ = try loginUseCase.executeLogin(email: email, password: password)
            onSuccess?()
            coordinator?.showTabBar()
        } catch UserRepositoryError.userNotFound {
            onError?("User not found")
        } catch UserRepositoryError.invalidPassword {
            onError?("Invalid password")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func showRegister() {
        coordinator?.showRegister()
    }
    
    func showTabBar() {
        coordinator?.showTabBar()
    }
}
