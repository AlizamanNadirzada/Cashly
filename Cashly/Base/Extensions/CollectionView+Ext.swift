//
//  CollectionView+Ext.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.09.25.
//

import UIKit

public protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    public static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {}
extension UICollectionReusableView: ReuseIdentifying {}
