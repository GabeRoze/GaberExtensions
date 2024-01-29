//
// Created by Gabriel Rozenberg on 2022-01-21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation


extension Collection {
	// adding support for computing indexes in a circular fashion
	public func circularIndex(after i: Index) -> Index {
		let nextIndex = index(after: i)
		return nextIndex == endIndex ? startIndex : nextIndex
	}

	public func circularIndex(before i: Index) -> Index {
		let previousIndex = index(i, offsetBy: -1)
		return previousIndex < startIndex ? (index(endIndex, offsetBy: -1))  : previousIndex
	}
}

extension Collection where Element: Equatable {
	// adding support for retrieving the next element in a circular fashion
	public func circularElement(after element: Element) -> Element? {
        return firstIndex(of: element).map { self[circularIndex(after: $0)] }
	}

	// adding support for retrieving the previous element in a circular fashion
	public func circularElement(before element: Element) -> Element? {
        return firstIndex(of: element).map { self[circularIndex(before: $0)] }
	}
}

// Protocol to allow iterating in place (similar to a type conforming to both Sequence and IteratorProtocol)
public protocol InPlaceIterable {
	mutating func next()
	mutating func previous()
}

extension InPlaceIterable where Self: CaseIterable, Self: Equatable {
	// adding default implementation for enums
	public mutating func next() {
		self = type(of: self).allCases.circularElement(after: self)!
	}

	public mutating func previous() {
		self = type(of: self).allCases.circularElement(before: self)!
	}
}
