//
//  UIDevice+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 5/22/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit
import AVFoundation

extension UIDevice {
	public static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

#endif
