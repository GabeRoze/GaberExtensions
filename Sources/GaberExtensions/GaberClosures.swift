//
//  Closures.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 3/26/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import SwiftUI

public typealias VoidClosure = () -> Void
public typealias CGPointClosure = (CGPoint) -> Void
public typealias StringClosure = (String?) -> Void
public typealias StringArrayClosure = ([String]) -> Void
public typealias TextClosure = (String?) -> Void
public typealias BoolClosure = (Bool) -> Void
public typealias IntClosure = (Int) -> Void
public typealias IndexPathClosure = (IndexPath) -> Void
public typealias CallbackClosure = (BoolClosure?) -> Void
public typealias DateClosure = (Date?) -> Void
public typealias ImageClosure = (UIImage?) -> Void
public typealias BoolCallbackClosure = (BoolClosure?) -> Void
public typealias ErrorClosure = (Error?) -> Void

#if os(iOS) || os(tvOS) || os(macOS)

public typealias CellClosure = (UICollectionViewCell) -> Void
public typealias FocusClosure = (UICollectionViewCell) -> Void

#endif
