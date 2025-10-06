//
//  CardEntity.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import Foundation

struct CardEntity: Hashable {
    let id: String
    let balance: Int
    let expiryDate: Date
    let last4Digits: String
    let logo: String
    let type: String
}
