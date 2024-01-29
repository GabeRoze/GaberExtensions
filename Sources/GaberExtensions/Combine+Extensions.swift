//
//  Combine+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 2/16/22.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Combine

extension Publisher {

	public func by<Key, Value>(_ key: Key) -> Publishers.Map<Self, Value?> where Output == [Key: Value] {

        return self.map { dictionary in
            dictionary.first(where: { $0.key == key })?.value
        }
    }
}
