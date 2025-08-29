//
//  Colors.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 25.08.25.
//

import UIKit

extension UIColor {
    
    // MARK: Base
    public static let button01: UIColor = .init(hex: "00AF32")
    
    // MARK: Text & Icon
    public static let base01: UIColor = .init(hex: "009D2D")
}

extension UIColor {
    /// #FF00FF or FF00FF
    /// #FF00FFAA or FF00FFAA // AA is alpha
    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex = hex.hasPrefix("#") ? hex.replacingOccurrences(of: "#", with: "") : hex

        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)

        if hex.count >= 8 {
            let red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            let green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            let blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            let alphaHex = CGFloat(rgbValue & 0x000000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alphaHex)
        } else {
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}
