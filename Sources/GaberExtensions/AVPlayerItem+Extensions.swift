//
//  AVPlayerItem+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 5/27/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import AVFoundation

extension AVPlayerItem {

	public convenience init?(asset: AVAsset?) {
        guard let asset = asset else {
            return nil
        }

        self.init(asset: asset)
    }
}

#endif
