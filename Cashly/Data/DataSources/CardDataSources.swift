//
//  CardDataSources.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation
import RealmSwift

class CardDataSource {
    private let realm = try! Realm()
    
    func saveCard(_ card: CardModel) {
        try! realm.write {
            realm.add(card, update: .all)
        }
    }
    
    func deleteCard(_ card: CardModel) {
        try! realm.write {
            realm.delete(card)
        }
    }
    
    func fetchAllCards() -> [CardModel] {
        return Array(realm.objects(CardModel.self))
    }
}
