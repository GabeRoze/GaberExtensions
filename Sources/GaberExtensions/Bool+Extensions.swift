//
//  Bool+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 3/2/22.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension Bool {
	public static var iOS15: Bool {
         if #available(iOS 15, *) {
             return true
         }

         return false
     }
 }
