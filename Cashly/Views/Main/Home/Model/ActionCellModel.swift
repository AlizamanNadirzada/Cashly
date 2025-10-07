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
    case transfer
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
            ActionCellModel(iconName: "plus.square.on.square", title: "Add Card", type: .add),
            ActionCellModel(iconName: "trash", title: "Delete Card", type: .delete),
            ActionCellModel(iconName: "arrow.right.arrow.left", title: "Transfer", type: .transfer)
        ]
    }
}

