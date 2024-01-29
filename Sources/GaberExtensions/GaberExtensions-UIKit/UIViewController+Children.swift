//
// Created by Gabriel Rozenberg on 2022-02-18.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

extension UIViewController {
	public func addVC(_ child: UIViewController) {
		view.addSubview(child.view)
		addChild(child)
		child.didMove(toParent: self)
	}

	public 	func removeVC() {
		// Just to be safe, we check that this view controller
		// is actually added to a parent before removing it.
		guard parent != nil else {
			return
		}

		willMove(toParent: nil)
		removeFromParent()
		view.removeFromSuperview()
	}
}

#endif
