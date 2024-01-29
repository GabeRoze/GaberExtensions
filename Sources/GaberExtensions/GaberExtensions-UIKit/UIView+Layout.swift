//
//  UIView+Layout.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 3/19/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

public extension UIView {

	func removeAllConstraints() {
        var _superview = superview

        while let superview = _superview {
            for constraint in superview.constraints {

                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        removeConstraints(constraints)
        translatesAutoresizingMaskIntoConstraints = true
    }

     enum LayoutKey {
        case top
        case bottom
        case lastBaseline
        case firstBaseline
        case left
        case right
        case width
        case height
        case centerX
        case centerY
        case leading
        case trailing
    }

     enum LayoutEquality {
        case equal
        case greaterThanOrEqual
        case lessThanOrEqual
    }

     struct LayoutAnchor {

        public enum Anchor {
            case top(NSLayoutAnchor<NSLayoutYAxisAnchor>)
            case bottom(NSLayoutAnchor<NSLayoutYAxisAnchor>)
            case lastBaseline(NSLayoutAnchor<NSLayoutYAxisAnchor>)
            case firstBaseline(NSLayoutAnchor<NSLayoutYAxisAnchor>)
            case left(NSLayoutAnchor<NSLayoutXAxisAnchor>)
            case right(NSLayoutAnchor<NSLayoutXAxisAnchor>)
            case leading(NSLayoutAnchor<NSLayoutXAxisAnchor>)
            case trailing(NSLayoutAnchor<NSLayoutXAxisAnchor>)
            case centerX(NSLayoutAnchor<NSLayoutXAxisAnchor>)
            case centerY(NSLayoutAnchor<NSLayoutYAxisAnchor>)
            case width(NSLayoutAnchor<NSLayoutDimension>?)
            case height(NSLayoutAnchor<NSLayoutDimension>?)
        }

        public let anchor: Anchor
        public let constant: CGFloat
        public let multiplier: CGFloat
        public let equality: LayoutEquality
        public let priority: UILayoutPriority

        public static func top(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .top(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func bottom(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .bottom(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func lastBaseline(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .lastBaseline(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func firstBaseline(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .firstBaseline(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func left(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .left(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func right(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .right(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func leading(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .leading(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func trailing(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .trailing(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func centerX(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .centerX(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func centerY(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .centerY(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func width(to anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .width(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func height(to anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat = 0, multiplier: CGFloat = 1, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> LayoutAnchor {
            return LayoutAnchor(anchor: .height(anchor), constant: constant, multiplier: multiplier, equality: equality, priority: priority)
        }

        public static func size(_ size: CGSize, equality: LayoutEquality = .equal, priority: UILayoutPriority = .required) -> [LayoutAnchor] {
            return [LayoutAnchor(anchor: .width(nil), constant: size.width, multiplier: 1, equality: equality, priority: priority),
                    LayoutAnchor(anchor: .height(nil), constant: size.height, multiplier: 1, equality: equality, priority: priority)
            ]
        }
    }

    @discardableResult
     func layout(_ constraints: [LayoutAnchor]) -> [LayoutKey: NSLayoutConstraint] {

        self.translatesAutoresizingMaskIntoConstraints = false

        var finalContraints = [LayoutKey: NSLayoutConstraint]()
        for constraint in constraints {
            switch constraint.anchor {
            case .top(let anchor):
                let newConstraint = self.layoutConstraint(topAnchor, to: anchor, layout: constraint)
                finalContraints[.top] = newConstraint
            case .bottom(let anchor):
                let newConstraint = self.layoutConstraint(bottomAnchor, to: anchor, layout: constraint)
                finalContraints[.bottom] = newConstraint
            case .lastBaseline(let anchor):
                let newConstraint = self.layoutConstraint(lastBaselineAnchor, to: anchor, layout: constraint)
                finalContraints[.lastBaseline] = newConstraint
            case .firstBaseline(let anchor):
                let newConstraint = self.layoutConstraint(firstBaselineAnchor, to: anchor, layout: constraint)
                finalContraints[.firstBaseline] = newConstraint
            case .left(let anchor):
                let newConstraint = self.layoutConstraint(leftAnchor, to: anchor, layout: constraint)
                finalContraints[.left] = newConstraint
            case .right(let anchor):
                let newConstraint = self.layoutConstraint(rightAnchor, to: anchor, layout: constraint)
                finalContraints[.right] = newConstraint
            case .leading(let anchor):
                let newConstraint = self.layoutConstraint(leadingAnchor, to: anchor, layout: constraint)
                finalContraints[.leading] = newConstraint
            case .trailing(let anchor):
                let newConstraint = self.layoutConstraint(trailingAnchor, to: anchor, layout: constraint)
                finalContraints[.trailing] = newConstraint
            case .centerX(let anchor):
                let newConstraint = self.layoutConstraint(centerXAnchor, to: anchor, layout: constraint)
                finalContraints[.centerX] = newConstraint
            case .centerY(let anchor):
                let newConstraint = self.layoutConstraint(centerYAnchor, to: anchor, layout: constraint)
                finalContraints[.centerY] = newConstraint
            case .width(let anchor):
                let newConstraint = self.layoutConstraint(widthAnchor, to: anchor as? NSLayoutDimension, layout: constraint)
                finalContraints[.width] = newConstraint
            case .height(let anchor):
                let newConstraint = self.layoutConstraint(heightAnchor, to: anchor as? NSLayoutDimension, layout: constraint)
                finalContraints[.height] = newConstraint
            }
        }

        return finalContraints
    }

    @discardableResult
    func layoutConstraint<A>(_ anchor: NSLayoutAnchor<A>, to secondAnchor: NSLayoutAnchor<A>, layout: LayoutAnchor) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch layout.equality {
        case .equal:
            constraint = anchor.constraint(equalTo: secondAnchor, constant: layout.constant)
        case .lessThanOrEqual:
            constraint = anchor.constraint(lessThanOrEqualTo: secondAnchor, constant: layout.constant)
        case .greaterThanOrEqual:
            constraint = anchor.constraint(greaterThanOrEqualTo: secondAnchor, constant: layout.constant)
        }
        constraint.priority = layout.priority
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    func layoutConstraint(_ anchor: NSLayoutDimension, to secondAnchor: NSLayoutDimension?, layout: LayoutAnchor) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch layout.equality {
        case .equal:
            if let secondAnchor = secondAnchor {
                constraint = anchor.constraint(equalTo: secondAnchor, multiplier: layout.multiplier)
            } else {
                constraint = anchor.constraint(equalToConstant: layout.constant)
            }
        case .lessThanOrEqual:
            if let secondAnchor = secondAnchor {
                constraint = anchor.constraint(lessThanOrEqualTo: secondAnchor, multiplier: layout.multiplier)
            } else {
                constraint = anchor.constraint(lessThanOrEqualToConstant: layout.constant)
            }

        case .greaterThanOrEqual:
            if let secondAnchor = secondAnchor {
                constraint = anchor.constraint(greaterThanOrEqualTo: secondAnchor, multiplier: layout.multiplier)
            } else {
                constraint = anchor.constraint(greaterThanOrEqualToConstant: layout.constant)
            }
        }
        constraint.priority = layout.priority
        constraint.isActive = true

        return constraint
    }

    @discardableResult
	func layoutEqualTo(_ view: UIView, insets: UIEdgeInsets = .zero) -> [LayoutKey: NSLayoutConstraint] {
        return self.layout([.top(to: view.topAnchor, constant: insets.top),
                            .left(to: view.leftAnchor, constant: insets.left),
                            .right(to: view.rightAnchor, constant: insets.right),
                            .bottom(to: view.bottomAnchor, constant: insets.bottom)])
    }

    @discardableResult
    func safeLayoutEqualTo(_ view: UIView, insets: UIEdgeInsets = .zero) -> [LayoutKey: NSLayoutConstraint] {
        return self.layout([.top(to: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
                            .left(to: view.leftAnchor, constant: insets.left),
                            .right(to: view.rightAnchor, constant: insets.right),
                            .bottom(to: view.bottomAnchor, constant: insets.bottom)])
    }
}

#endif
