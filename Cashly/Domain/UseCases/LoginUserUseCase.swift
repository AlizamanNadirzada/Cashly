//
//  LoginUseCase.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 18.09.25.
//

import Foundation

final class LoginUserUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func executeLogin(email: String, password: String) throws -> UserEntity {
        return try repository.login(email: email, password: password)
    }
}

