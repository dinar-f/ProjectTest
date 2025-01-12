//
//  UIColor.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexParsed = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexParsed = hexParsed.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexParsed).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
