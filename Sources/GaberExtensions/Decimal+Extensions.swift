//
// Created by Gabriel Rozenberg on 2022-05-06.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension Decimal {
	public var doubleValue: Double {
		NSDecimalNumber(decimal: self).doubleValue
	}
}

extension Decimal {
	public var removeZero: String {
		let nf = NumberFormatter()
		nf.minimumFractionDigits = 0
		nf.maximumFractionDigits = 2
		return nf.string(for: self) ?? ""
	}
}
