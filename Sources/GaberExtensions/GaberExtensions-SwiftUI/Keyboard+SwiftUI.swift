//
//  File.swift
//
//
//  Created by Gabriel Rozenberg on 2022-06-23.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(macOS)

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
public extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#endif

// https://developer.apple.com/forums/thread/688678
public struct FocusModifier: ViewModifier {

	@available(iOS 15.0, watchOS 8.0, *)
	@FocusState var focused: Bool
	@Binding var state: Bool

	public init(_ state: Binding<Bool>){
		self._state = state
	}

	public func body(content: Content) -> some View {
		if #available(watchOS 8.0, iOS 15.0, *) {
			content.focused($focused, equals: true)
				.onChange(of: state, perform: changeFocus)
		} else {
			content
		}
	}

	private func changeFocus(_ value: Bool) {
		if #available(watchOS 8.0, iOS 15.0, *) {
			focused = value
		}
	}
}

extension View{
	public func focusMe(state: Binding<Bool>) -> some View {
		self.modifier(FocusModifier(state))
	}
}
