//
// Created by Gabriel Rozenberg on 2022-02-02.//

import SwiftUI

public extension Color {

	static func hexString(_ hexString: String) -> Color {

		// Strip # or 0x out of string
		let hexString = hexString.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "0x", with: "")
		let hexType = hexString.count

		// Default color is clear which is normal default on UIKit
		guard let hexValue = Int(hexString, radix: 16) else {
			return Color(white: 0, opacity: 0)
		}

		switch hexType {
		case 3:
			return .hex3(hexValue)
		case 4:
			return .hex4(hexValue)
		case 6:
			return .hex6(hexValue)
		default:
			return Color(white: 0, opacity: 0)
		}
	}

	static func hex3(_ hex3: Int) -> Color {
		let divisor = CGFloat(15)
		let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
		let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
		let blue = CGFloat( hex3 & 0x00F) / divisor
		return Color(.sRGB, red: red, green: green, blue: blue, opacity: 1)
	}

	static func hex4(_ hex4: Int) -> Color {
		let divisor = CGFloat(15)
		let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
		let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
		let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
		let alpha = CGFloat( hex4 & 0x000F) / divisor
		return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
	}

	static func hex6(_ hex6: Int) -> Color {
		let divisor = CGFloat(255)
		let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
		let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
		let blue = CGFloat( hex6 & 0x0000FF) / divisor
		return Color(.sRGB, red: red, green: green, blue: blue, opacity: 1)
	}
}
