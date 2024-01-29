//
//  TimeInterval+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 9/20/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension TimeInterval {

    // Convert the seconds, minutes, hours into a string.
    public func elapsedTimeString() -> String {
        let elapsed = self.secondsToHoursMinutesSeconds(seconds: self)

        if elapsed.0 == 0 {
            return String(format: "%02d:%02d", elapsed.1, elapsed.2)
        } else {
            return String(format: "%02d:%02d:%02d", elapsed.0, elapsed.1, elapsed.2)
        }
    }

    // Convert the seconds into seconds, minutes, hours.
	public func secondsToHoursMinutesSeconds (seconds: TimeInterval) -> (Int, Int, Int) {
      return (Int(seconds / 3600), (Int(seconds) % 3600) / 60, (Int(seconds) % 3600) % 60)
    }
}
