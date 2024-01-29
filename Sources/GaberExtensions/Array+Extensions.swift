//
//  Array+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 1/6/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension Array {
    public func toAnyDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key: Element] {
        var dict = [Key: Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
    
    // https://stackoverflow.com/questions/34161786/reduce-array-to-set-in-swift
    public func mapToSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
        var result = Set<T>()
        for item in self {
            result.insert(transform(item))
        }
        return result
    }
}

//https://stackoverflow.com/questions/25738817/removing-duplicate-elements-from-an-array-in-swift
// filters only unique values
extension Sequence where Element: Hashable {
    public func uniquesOnly() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    public var second: Element? {
        return nth(1)
    }

    public var third: Element? {
        return nth(2)
    }

    public func nth(_ index: Int) -> Element? {
        if count > index {
            return self[index]
        } else {
            return nil
        }
    }
}

extension Array where Element: Hashable {
    public func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension Array where Element == Double {

    public func sum() -> Double {
        return self.reduce(0) { result, element in
            return result + element
        }
    }

    public func average() -> Double {
        return self.sum() / Double(self.count)
    }
}
