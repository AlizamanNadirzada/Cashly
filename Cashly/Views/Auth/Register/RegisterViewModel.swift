//
//  RegisterViewModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 25.08.25.
//

import UIKit

final class RegisterViewModel {
    private weak var coordinator: AuthCoordinator?
    private let registerUseCase: RegisterUserUseCase
        
    var onSuccess: (() -> Void)?
    
    init(coordinator: AuthCoordinator? = nil, registerUseCase: RegisterUserUseCase) {
        self.coordinator = coordinator
        self.registerUseCase = registerUseCase
    }
    
    func register(user: UserEntity) {
        do {
            try registerUseCase.executeRegister(user: user)
            onSuccess?()
            coordinator?.showLogin()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func showLogin() {
        coordinator?.showLogin()
    }
}
