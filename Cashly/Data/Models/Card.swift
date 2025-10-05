//
//  Card.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 01.10.25.
//

import Foundation
import RealmSwift

class CardModel: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var balance: Int = 0
    @Persisted var expiryDate: Date = Date()
    @Persisted var last4Digits: String = ""
    @Persisted var logo: String = ""
    
    // Mapping to Domain Entity
    func toEntity() -> CardEntity {
        return CardEntity(
            id: id,
            balance: balance,
            expiryDate: expiryDate,
            last4Digits: last4Digits,
            logo: logo
        )
    }
    
    // Mapping from Domain Entity
    convenience init(entity: CardEntity) {
        self.init()
        self.id = entity.id
        self.balance = entity.balance
        self.expiryDate = entity.expiryDate
        self.last4Digits = entity.last4Digits
        self.logo = entity.logo
    }
}



