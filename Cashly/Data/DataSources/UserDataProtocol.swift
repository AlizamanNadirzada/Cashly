//
//  UserDataProtocol.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 28.09.25.
//

import Foundation

protocol UserDataProtocol {
    func saveUser(_ user: UserObject) throws
    func getUserByEmail(_ email: String) -> UserObject?
}
