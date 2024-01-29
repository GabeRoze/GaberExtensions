//
//  File.swift
//  
//
//  Created by Gabriel Rozenberg on 6/7/22.
//

import Foundation

public extension Array where Element == URLQueryItem {
  /// Returns new list of query items replaces any existing
  func merging(_ other: [URLQueryItem]) -> [URLQueryItem] {
    var queryItems = self

    queryItems.merge(other)

    return queryItems
  }

  /// Merges list of query items replaces any existing
  mutating func merge(_ other: [URLQueryItem]) {
    for query in other {
      if let index = firstIndex(of: query.name) {
        replaceSubrange(index ... index, with: [query])
      } else {
        append(query)
      }
    }
  }

  /// Returns the first index whose name matches the parameter
  func firstIndex(of name: String) -> Int? {
    return firstIndex { $0.name == name }
  }

  /// Creates a new query item and appends only if the value is not nil
  mutating func appendIfPresent(name: String, value: String?) {
    if let value = value {
      append(URLQueryItem(name: name, value: value))
    }
  }
}
