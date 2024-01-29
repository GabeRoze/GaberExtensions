//
//  Binding+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 12/10/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import SwiftUI
//import CasePaths

extension Binding {

    public func isPresent<Wrapped>() -> Binding<Bool>
            where Value == Wrapped? {
        .init(
                get: { self.wrappedValue != nil },
                set: { isPresented in
                    if !isPresented {
                        self.wrappedValue = nil
                    }
                }
        )
    }

    public init?(unwrap optionalValue: Binding<Value?>) {
        guard let value = optionalValue.wrappedValue else {
            return nil
        }

        self.init {
            value
        } set: { newValue in
            optionalValue.wrappedValue = newValue
        }
    }

    public func didSet(_ callback: @escaping (Value) -> Void) -> Self {
        .init(
                get: { self.wrappedValue },
                set: {
                    self.wrappedValue = $0
                    callback($0)
                }
        )
    }
}

extension Binding where Value == Bool {

    public init(userDefaultKey: String, negation: Bool = false) {
        self.init {
            if negation {
                return !UserDefaults.standard.bool(forKey: userDefaultKey)
            } else {
                return UserDefaults.standard.bool(forKey: userDefaultKey)
            }
        } set: { value in
            var newValue = value
            if negation {
                newValue = !value
            }
            UserDefaults.standard.set(newValue, forKey: userDefaultKey)
        }
    }
}

extension Binding {

//    public func isPresent<Enum, Case>(_ casePath: CasePath<Enum, Case>) -> Binding<Bool>
//            where Value == Enum? {
//        Binding<Bool>(
//                get: {
//                    if let wrappedValue = self.wrappedValue, casePath.extract(from: wrappedValue) != nil {
//                        return true
//                    } else {
//                        return false
//                    }
//                },
//                set: { isPresented in
//                    if !isPresented {
//                        self.wrappedValue = nil
//                    }
//                }
//        )
//    }
//
//    public func `case`<Enum, Case>(_ casePath: CasePath<Enum, Case>) -> Binding<Case?>
//            where Value == Enum? {
//        Binding<Case?>(
//                get: {
//                    guard
//                            let wrappedValue = self.wrappedValue,
//                            let `case` = casePath.extract(from: wrappedValue)
//                    else { return nil }
//                    return `case`
//                },
//                set: { `case` in
//                    if let `case` = `case` {
//                        self.wrappedValue = casePath.embed(`case`)
//                    } else {
//                        self.wrappedValue = nil
//                    }
//                }
//        )
//    }
}
