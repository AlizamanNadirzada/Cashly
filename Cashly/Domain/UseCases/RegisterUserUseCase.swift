//
//  RegisterUseCase.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 18.09.25.
//

import Foundation

final class RegisterUserUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func executeRegister(user: UserEntity) throws {
        try repository.register(user: user)
    }
}
