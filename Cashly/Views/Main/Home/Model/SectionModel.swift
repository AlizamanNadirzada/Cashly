//
//  SectionModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.09.25.
//

import Foundation

enum HomeSection: Hashable {
    case cards
    case actions
    case operations
}

enum HomeItem: Hashable {
    case card(CardEntity)
    case action(ActionCellModel)
    case operation(OperationCellModel)
}

