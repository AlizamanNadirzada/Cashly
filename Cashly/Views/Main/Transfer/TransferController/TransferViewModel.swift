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

    var onUpdate: (() -> Void)?
    var onTransferSuccess: (() -> Void)?
    var onTransferFailure: ((String) -> Void)?

    private let cardUseCase: CardUseCase

    init(cardUseCase: CardUseCase = CardUseCase(repository: CardRepositoryImpl())) {
        self.cardUseCase = cardUseCase
    }

    func resetFromCard() { selectedFromCard = nil }
    func resetToCard() { selectedToCard = nil }

    func performTransfer(amountText: String) {
        guard let amount = Int(amountText),
              let from = selectedFromCard,
              let to = selectedToCard else {
            onTransferFailure?("Invalid transfer data")
            return
        }

        do {
            try cardUseCase.transfer(amount: amount, from: from, to: to)
            onTransferSuccess?()
        } catch {
            let message = (error as? TransferError)?.errorDescription ?? "Unexpected error"
            onTransferFailure?(message)
        }
    }
}
