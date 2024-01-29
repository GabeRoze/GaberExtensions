//
//  Calendar+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 8/17/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension Calendar {
	public func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)

        return numberOfDays.day!
    }
}
