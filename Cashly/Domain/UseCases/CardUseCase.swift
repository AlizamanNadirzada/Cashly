//
//  CardUseCase.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation

enum TransferError: LocalizedError {
    case invalidAmount
    case sameCard
    case insufficientFunds
    case cardNotFound
    case realmError(String)

    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "Invalid amount entered."
        case .sameCard:
            return "You cannot transfer between the same card."
        case .insufficientFunds:
            return "Insufficient funds on the source card."
        case .cardNotFound:
            return "Card not found."
        case .realmError(let message):
            return "Database error: \(message)"
        }
    }
}

final class CardUseCase {
    private let repository: CardRepositoryProtocol
    private(set) var cards: [CardEntity] = []
    
    init(repository: CardRepositoryProtocol) {
        self.repository = repository
        self.cards = repository.getAllCards()
    }
    
    // Create random card
    func createRandomCard() -> CardEntity {
        let balance = Int.random(in: 50...5000)
        
        var dateComponents = DateComponents()
        dateComponents.year = Int.random(in: 2025...2030)
        dateComponents.month = Int.random(in: 1...12)
        let expiry = Calendar.current.date(from: dateComponents) ?? Date()
        
        let last4 = String(format: "%04d", Int.random(in: 0...9999))
        let logo = Bool.random() ? "visa" : "master"
        
        let visaCardTypes = ["Visa Standard", "Visa Business"]
        let masterCardTypes = ["Mastercard Standard", "Mastercard Classic", "Mastercard International"]
        let type: String
        if logo == "visa" {
            type = visaCardTypes.randomElement() ?? "Visa Standard"
        } else {
            type = masterCardTypes.randomElement() ?? "Mastercard Standard"
        }
        
        return CardEntity(
            id: UUID().uuidString,
            balance: balance,
            expiryDate: expiry,
            last4Digits: last4,
            logo: logo,
            type: type
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
    
    func transfer(amount: Int, from fromCard: CardEntity, to toCard: CardEntity) throws {
        guard amount > 0 else {
            throw TransferError.invalidAmount
        }
        
        guard fromCard.id != toCard.id else {
            throw TransferError.sameCard
        }
        
        guard fromCard.balance >= amount else {
            throw TransferError.insufficientFunds
        }
        
        try repository.transfer(amount: amount, from: fromCard, to: toCard)
        
        self.cards = repository.getAllCards()
    }
}

