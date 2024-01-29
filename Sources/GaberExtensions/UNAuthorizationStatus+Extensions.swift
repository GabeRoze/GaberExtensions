//
//  UNAuthorizationStatus+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 11/30/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import UserNotifications

extension UNAuthorizationStatus {

	public func canReceivePush() -> Bool {
        switch self {
        case .authorized, .provisional, .ephemeral:
            return true
        default:
            return false
        }
    }
}
