//
//  CGSize+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 6/29/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import CoreGraphics

extension CGSize {

	public func scale(by factor: CGFloat) -> CGSize {
        return CGSize(width: self.width * factor, height: self.height * factor)
    }
}
