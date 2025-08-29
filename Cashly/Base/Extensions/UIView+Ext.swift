//
//  UIView+Ext.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 29.08.25.
//

import UIKit

extension UIView {
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

extension UIStackView {
    public func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
