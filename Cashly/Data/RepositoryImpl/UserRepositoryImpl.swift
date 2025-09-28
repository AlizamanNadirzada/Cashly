//
//  UserRepositoryImpl.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 18.09.25.
//

import Foundation

enum UserRepositoryError: Error {
    case userAlreadyExists
    case userNotFound
    case invalidPassword
}

final class UserRepositoryImpl: UserRepository {
    private let localDatasource: UserDataProtocol
    
    init(localDatasource: UserDataProtocol) {
        self.localDatasource = localDatasource
    }
    
    func register(user: UserEntity) throws {
        if localDatasource.getUserByEmail(user.email) != nil {
            throw UserRepositoryError.userAlreadyExists
        }
        
        let userObject = UserObject()
        userObject.id = user.id
        userObject.name = user.name
        userObject.surname = user.surname
        userObject.email = user.email
        userObject.phone = user.phone
        userObject.password = user.password
        userObject.birthday = user.birthday
        
        try localDatasource.saveUser(userObject)
    }
    
    func login(email: String, password: String) throws -> UserEntity {
        guard let userObject = localDatasource.getUserByEmail(email) else {
            throw UserRepositoryError.userNotFound
        }
        
        guard userObject.password == password else {
            throw UserRepositoryError.invalidPassword
        }
        
        return UserEntity(
            id: userObject.id,
            name: userObject.name,
            surname: userObject.surname,
            email: userObject.email,
            phone: userObject.phone,
            password: userObject.password,
            birthday: userObject.birthday
        )
    }
}

