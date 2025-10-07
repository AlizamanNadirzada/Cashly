//
//  OperationCellModel.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation

struct OperationCellModel: Hashable {
    let iconName: String
    let title: String
}

extension OperationCellModel {
    static func mockData() -> [OperationCellModel] {
        return [
            .init(iconName: "eye", title: "Check Limit"),
            .init(iconName: "exclamationmark.bubble", title: "Report Problems"),
            .init(iconName: "flag.fill", title: "Favourites"),
            .init(iconName: "deskview", title: "View Details")
        ]
    }
}
