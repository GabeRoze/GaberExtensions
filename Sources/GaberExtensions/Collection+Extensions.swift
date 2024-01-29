//
// Created by Gabriel Rozenberg on 2022-02-15.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import SwiftUI

// https://www.swiftbysundell.com/articles/bindable-swiftui-list-elements/
extension ForEach where ID == Data.Element.ID, Data.Element: Identifiable, Content: View {
	public init<T>(_ indices: Data,
			@ViewBuilder content: @escaping (Data.Index) -> Content
	) where Data == IdentifiableIndices<T> {
		self.init(indices) { index in
			content(index.rawValue)
		}
	}
}

extension RandomAccessCollection where Element: Identifiable {
	public var identifiableIndices: IdentifiableIndices<Self> {
		IdentifiableIndices(base: self)
	}
}

extension IdentifiableIndices: RandomAccessCollection {
	public var startIndex: Index { base.startIndex }
	public var endIndex: Index { base.endIndex }

	public subscript(position: Index) -> Element {
		Element(id: base[position].id, rawValue: position)
	}

	public func index(before index: Index) -> Index {
		base.index(before: index)
	}

	public func index(after index: Index) -> Index {
		base.index(after: index)
	}
}

public struct IdentifiableIndices<Base: RandomAccessCollection>
		where Base.Element: Identifiable {

	public typealias Index = Base.Index

	public struct Element: Identifiable {
		public let id: Base.Element.ID
		public let rawValue: Index
	}

	public var base: Base
}

extension Collection {
	// https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	public subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
