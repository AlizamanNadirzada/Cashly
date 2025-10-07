//
//  HomeViewModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.08.25.
//


import Foundation

import Foundation

final class HomeViewModel {

    private let cardUseCase = CardUseCase(repository: CardRepositoryImpl())
    private var data: [HomeSection: [HomeItem]] = [:]
    private(set) var cards: [CardEntity] = []
    var onSnapshotUpdate: (([HomeSection: [HomeItem]]) -> Void)?

    init() {
        loadInitialData()
    }
    
    func loadInitialData() {
        // Cards section
        self.cards = cardUseCase.cards
        let cardItems = cards.map { HomeItem.card($0) }
        data[.cards] = cardItems
        
        // Actions section
        let actionItems = ActionCellModel.mockData().map { HomeItem.action($0) }
        data[.actions] = actionItems
        
        // Operation Cell
        let operationItems = OperationCellModel.mockData().map { HomeItem.operation($0) }
        data[.operations] = operationItems
        
        onSnapshotUpdate?(data)
    }

    // MARK: - Add New Card
    func addRandomCard() {
        cardUseCase.addRandomCard()
        updateCardsSection()
    }

    // MARK: - Delete Card
    func deleteCard(at index: Int) {
        cardUseCase.deleteCard(at: index)
        updateCardsSection()
    }

    private func updateCardsSection() {
        let cardItems = cardUseCase.cards.map { HomeItem.card($0) }
        data[.cards] = cardItems
        onSnapshotUpdate?(data)
    }
}
