//
//  CardRepositoryProtocol.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation

protocol CardRepositoryProtocol {
    func addCard(_ card: CardEntity)
    func deleteCard(_ card: CardEntity)
    func getAllCards() -> [CardEntity]
}

