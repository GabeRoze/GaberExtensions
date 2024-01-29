//
//  UIScrollView+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 4/8/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import Foundation
import UIKit

extension UIScrollView {
    // Bonus: Scroll to bottom
    public func scrollToBottom() {
            let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
            if bottomOffset.y > 0 {
                setContentOffset(bottomOffset, animated: true)
            }
        }

    public func scrollToTop() {
        setContentOffset(.zero, animated: true)
    }
}

#endif
