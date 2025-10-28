//
//  TransferViewModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 21.10.25.
//

import Foundation

final class TransferViewModel {
    var selectedFromCard: CardEntity? {
        didSet { onUpdate?() }
    }
    var selectedToCard: CardEntity? {
        didSet { onUpdate?() }
    }

    var cards: [CardEntity] = []
    private let cardUseCase: CardUseCase
    var onUpdate: (() -> Void)?

    init(cardUseCase: CardUseCase = CardUseCase(repository: CardRepositoryImpl())) {
        self.cardUseCase = cardUseCase
    }

    func resetFromCard() { selectedFromCard = nil }
    func resetToCard() { selectedToCard = nil }
}
