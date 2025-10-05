//
//  CardUseCase.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation

class CardUseCase {
    private let repository: CardRepositoryProtocol
    private(set) var cards: [CardEntity] = []
    
    init(repository: CardRepositoryProtocol) {
        self.repository = repository
        self.cards = repository.getAllCards()
        
        if cards.isEmpty {
            let defaultCard = createDefaultCard()
            repository.addCard(defaultCard)
            cards.append(defaultCard)
        }
    }
    
    // Default Card
    private func createDefaultCard() -> CardEntity {
        return CardEntity(
            id: UUID().uuidString,
            balance: 1000, // default balans
            expiryDate: Calendar.current.date(byAdding: .year, value: 3, to: Date()) ?? Date(),
            last4Digits: "1234",
            logo: "visa"
        )
    }
    
    // Create random card
    func createRandomCard() -> CardEntity {
        let balance = Int.random(in: 50...1000)
        
        var dateComponents = DateComponents()
        dateComponents.year = Int.random(in: 2025...2030)
        dateComponents.month = Int.random(in: 1...12)
        let expiry = Calendar.current.date(from: dateComponents) ?? Date()
        
        let last4 = String(format: "%04d", Int.random(in: 0...9999))
        let logo = Bool.random() ? "visa" : "master"
        
        return CardEntity(
            id: UUID().uuidString,
            balance: balance,
            expiryDate: expiry,
            last4Digits: last4,
            logo: logo
        )
    }
    
    // Add new Card
    func addRandomCard() {
        let newCard = createRandomCard()
        cards.append(newCard)
        repository.addCard(newCard)
    }
    
    // Delete Card
    func deleteCard(at index: Int) {
        guard cards.indices.contains(index) else { return }
        let card = cards.remove(at: index)
        repository.deleteCard(card)
    }
}

