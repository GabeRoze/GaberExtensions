//
//  UIColor+Hex.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 3/19/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

public extension UIColor {

	var toHexString: String {

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgba: Int = (Int)(r*255)<<24 | (Int)(g*255)<<16 | (Int)(b*255)<<8 | (Int)(a*255)<<0
        let hexString = String(format: "#%08x", rgba)
        return hexString
    }

    convenience init(hexString: String) {

        // Todo Strip # or 0x out of string
        let hexString = hexString.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "0x", with: "")
        let hexType = hexString.count

        // Todo Default color is clear which is normal default on UIKit
        guard let hexValue = Int(hexString, radix: 16) else {
            self.init(white: 0, alpha: 0)
            return
        }

        switch hexType {
        case 3:
            self.init(hex3: hexValue)
        case 4:
            self.init(hex4: hexValue)
        case 6:
            self.init(hex6: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            self.init(white: 0, alpha: 0)
        }

    }

	convenience init(hex3: Int) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue = CGFloat( hex3 & 0x00F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

	convenience init(hex4: Int) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let alpha = CGFloat( hex4 & 0x000F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

	convenience init(hex6: Int) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat( hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

    convenience init(hex8: Int) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue = CGFloat( (hex8 & 0x0000FF00) >> 8) / divisor
        let alpha = CGFloat( hex8 & 0x000000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
	public var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50 ? true : false
    }
}

extension UIColor {
	public func opacity(_ value: CGFloat) -> UIColor {

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        return UIColor(displayP3Red: r, green: g, blue: b, alpha: a * value)
    }
}

extension UIColor {
	public func toColor(_ color: UIColor, percentage: CGFloat) -> UIColor {
        let percentage = max(min(percentage, 1), 0)
        switch percentage {
        case 0: return self
        case 1: return color
        default:
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
            guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }

            return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                           green: CGFloat(g1 + (g2 - g1) * percentage),
                           blue: CGFloat(b1 + (b2 - b1) * percentage),
                           alpha: CGFloat(a1 + (a2 - a1) * percentage))
        }
    }
}

#endif
