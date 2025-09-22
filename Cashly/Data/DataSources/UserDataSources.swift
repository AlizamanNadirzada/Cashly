//
//  UserDataSources.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 18.09.25.
//

import Foundation
import RealmSwift

final class UserLocalDatasource {
    private let realm = try! Realm()
    
    func saveUser(_ user: UserObject) throws {
        try realm.write {
            realm.add(user, update: .modified)
        }
    }
    
    func getUserByEmail(_ email: String) -> UserObject? {
        realm.objects(UserObject.self).filter("email == %@", email).first
    }
}

