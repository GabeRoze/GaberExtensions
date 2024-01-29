//
//  View+TabBadge.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 3/2/22.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(macOS)

@available(iOS 15.0, *)
public struct TabModifier: ViewModifier {
	public let text: String?
	
	public init(text: String?) {
		self.text = text
	}

	public func body(content: Content) -> some View {
		content.badge(text)
	}
}


extension View {
	
	@ViewBuilder public func tabBadge(_ label: String?) -> some View {
		if #available(iOS 15.0, *) {
			self.modifier(TabModifier(text: label))
		} else {
			self
		}
	}
	
	/// Applies the given transform if the given condition evaluates to `true`.
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
	@ViewBuilder public func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
		if condition() {
			transform(self)
		} else {
			self
		}
	}
}

#endif
