//
//  URLComponents+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 8/19/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension URLComponents {

	public func queryItemValue(for key: String) -> String? {
        return self.queryItems?.first(where: { $0.name == key })?.value
    }
}
