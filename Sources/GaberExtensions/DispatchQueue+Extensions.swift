//
//  DispatchQueue+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 3/19/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//
import Foundation

extension DispatchQueue {
    public static func guardMain(_ closure: @escaping () -> Void) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                closure()
            }
            return
        }

        closure()
    }
}
