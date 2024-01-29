//
// Created by Gabriel Rozenberg on 2022-03-02.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import SwiftUI

// from https://stackoverflow.com/questions/57688242/swiftui-how-to-change-the-placeholder-color-of-the-textfield
public extension View {
	func placeholder<Content: View>(
			when shouldShow: Bool,
			alignment: Alignment = .leading,
			@ViewBuilder placeholder: () -> Content) -> some View {

		ZStack(alignment: alignment) {
			placeholder().opacity(shouldShow ? 1 : 0)
			self
		}
	}
}
