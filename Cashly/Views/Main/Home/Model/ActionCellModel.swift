//
//  ActionCellModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.09.25.
//

import Foundation

enum ActionType {
    case add
    case delete
    case transaction
}

struct ActionCellModel: Hashable {
    let id = UUID()
    let iconName: String
    let title: String
    let type: ActionType
}

extension ActionCellModel {
    static func mockData() -> [ActionCellModel] {
        return [
            ActionCellModel(iconName: "plus.circle", title: "Add Card", type: .add),
            ActionCellModel(iconName: "trash.circle", title: "Delete Card", type: .delete),
            ActionCellModel(iconName: "arrow.right.arrow.left.circle", title: "Transaction", type: .transaction)
        ]
    }
}

