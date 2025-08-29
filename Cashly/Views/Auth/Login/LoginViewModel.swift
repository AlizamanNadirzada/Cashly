//
//  LoginViewModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 25.08.25.
//

import UIKit

final class LoginViewModel {
    private weak var coordinator: AuthCoordinatorProtocol?
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func showRegister() {
        coordinator?.showRegister()
    }
}
