//
//  UserEntity.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 18.09.25.
//

import Foundation

/// It is a pure model used in the Domain layer.
struct UserEntity {
    let id: String
    let name: String
    let surname: String
    let email: String
    let phone: String
    let password: String
    let birthday: Date
}

