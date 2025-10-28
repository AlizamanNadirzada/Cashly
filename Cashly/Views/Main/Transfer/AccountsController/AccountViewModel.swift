//
//  AccountViewModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 21.10.25.
//

import Foundation

final class AccountViewModel {
    private let cardUseCase = CardUseCase(repository: CardRepositoryImpl())
    private(set) var cards: [CardEntity] = []
    var excludedCardId: String?

    var onReload: (() -> Void)?

    init() {
        loadCards()
    }

    private func loadCards() {
        var fetched = cardUseCase.cards
        if let excludedId = excludedCardId {
            fetched.removeAll { $0.id == excludedId }
        }
        cards = fetched
        onReload?()
    }
}
