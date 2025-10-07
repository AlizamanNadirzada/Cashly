//
//  CardRepositoryImpl.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation

final class CardRepositoryImpl: CardRepositoryProtocol {
    private let dataSource = CardDataSource()
    
    func addCard(_ card: CardEntity) {
        let model = CardModel(entity: card)
        dataSource.saveCard(model)
    }
    
    func deleteCard(_ card: CardEntity) {
        let models = dataSource.fetchAllCards()
        if let model = models.first(where: { $0.id == card.id }) {
            dataSource.deleteCard(model)
        }
    }
    
    func getAllCards() -> [CardEntity] {
        return dataSource.fetchAllCards().map { $0.toEntity() }
    }
}
