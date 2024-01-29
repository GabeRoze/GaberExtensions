//
//  UIView+Animations.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 8/10/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

extension UIView {

    public static func animate(view: UIView, fromPoint start: CGPoint, toPoint end: CGPoint, duration: Double) {
        // The animation
        let animation = CAKeyframeAnimation(keyPath: "position")

        // Animation's path
        let path = UIBezierPath()

        // Move the "cursor" to the start
        path.move(to: start)

        // Calculate the control points
        let c1 = CGPoint(x: start.x + 64, y: start.y)
        let c2 = CGPoint(x: end.x, y: end.y - 128)

        // Draw a curve towards the end, using control points
        path.addCurve(to: end, controlPoint1: c1, controlPoint2: c2)

        // Use this path as the animation's path (casted to CGPath)
        animation.path = path.cgPath

        // The other animations properties
        animation.fillMode              = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.duration              = duration
        animation.timingFunction        = CAMediaTimingFunction(name: .easeIn)

        // Apply it
        view.layer.add(animation, forKey: "trash")
    }

    public func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

#endif
