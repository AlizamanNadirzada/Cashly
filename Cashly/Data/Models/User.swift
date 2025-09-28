//
//  User.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 17.09.25.
//

import Foundation
import RealmSwift

final class UserObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var surname: String
    @Persisted var email: String
    @Persisted var phone: String
    @Persisted var password: String
    @Persisted var birthday: Date
}
