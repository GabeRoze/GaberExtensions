//
//  UICollectionViewCell+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 2/15/22.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import Foundation
import UIKit

extension UICollectionReusableView {

	public static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

#endif
