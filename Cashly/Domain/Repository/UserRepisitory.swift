//
//  UserRepisitory.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 18.09.25.
//

import Foundation

/// Provides an abstract interface for accessing and managing entities.
protocol UserRepository {
    func register(user: UserEntity) throws
    func login(email: String, password: String) throws -> UserEntity
}

