//
//  Data+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 4/6/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension Data {
	public func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
