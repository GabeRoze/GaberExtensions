//
//  UIView+AnchorPoint.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 5/22/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

extension UIView {
    public func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}

#endif
