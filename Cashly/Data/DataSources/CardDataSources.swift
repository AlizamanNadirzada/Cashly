//
//  CardDataSources.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation
import RealmSwift

final class CardDataSource {
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
    
    func transfer(amount: Int, fromId: String, toId: String) throws {
        guard let fromModel = realm.object(ofType: CardModel.self, forPrimaryKey: fromId),
              let toModel   = realm.object(ofType: CardModel.self, forPrimaryKey: toId) else {
            throw TransferError.cardNotFound
        }
        
        guard fromModel.id != toModel.id else {
            throw TransferError.sameCard
        }
        
        guard fromModel.balance >= amount else {
            throw TransferError.insufficientFunds
        }
        
        do {
            try realm.write {
                fromModel.balance -= amount
                toModel.balance += amount
            }
        } catch {
            throw TransferError.realmError(error.localizedDescription)
        }
    }
}
