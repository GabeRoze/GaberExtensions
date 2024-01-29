//
//  Date+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 6/1/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//
import Foundation
import CoreGraphics

extension Calendar {
	public static let iso8601 = Calendar(identifier: .iso8601)
	public static let iso8601UTC: Calendar = {
		var calendar = Calendar(identifier: .iso8601)
		calendar.timeZone = TimeZone(identifier: "UTC")!
		return calendar
	}()
}

extension Date {

	public func dayOfTheWeek() -> Weekday? {
		let day = Calendar.current.component(.weekday, from: self)
		switch day {
		case 1: return .sunday
		case 2: return .monday
		case 3: return .tuesday
		case 4: return .wednesday
		case 5: return .thursday
		case 6: return .friday
		case 7: return .saturday
		default: return nil
		}
	}

	public func dayOfTheWeekString() -> String? {
		let day = Calendar.current.component(.weekday, from: self)
		switch day {
		case 1: return "Sunday"
		case 2: return "Monday"
		case 3: return "Tuesday"
		case 4: return "Wednesday"
		case 5: return "Thursday"
		case 6: return "Friday"
		case 7: return "Saturday"
		default: return nil
		}
	}

	public var month: String {
		let names = Calendar.current.monthSymbols
		let month = Calendar.current.component(.month, from: self)
		return names[month - 1] // todo should this be -1?
	}

	public var year: String {
		let year = Calendar.current.component(.year, from: self)
		return "\(year)"
	}

	public func startOfWeek(using calendar: Calendar = .iso8601) -> Date {
		calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
	}

	public func endOfWeek(using calendar: Calendar = .iso8601) -> Date {
		var date = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!

		date = calendar.date(byAdding: .day, value: 6, to: date)!
		return date
	}

	public func minutesBetweenDates(_ newDate: Date?) -> CGFloat {
		guard let newDate = newDate else {
			return 0
		}

		// get both times sinces refrenced date and divide by 60 to get minutes
		let newDateMinutes = newDate.timeIntervalSinceReferenceDate/60
		let oldDateMinutes = self.timeIntervalSinceReferenceDate/60

		// then return the difference
		return abs(CGFloat(newDateMinutes - oldDateMinutes))
	}

	public static var highPercisionTimeInterval: UInt64 {
		return UInt64(Date().timeIntervalSince1970 * 10000000)
	}

	public func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
		return calendar.dateComponents(Set(components), from: self)
	}

	public func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
		return calendar.component(component, from: self)
	}

	public func abbreviatedFormat(to date: Date) -> String {
		let formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.day, .hour, .minute, .second]
		formatter.unitsStyle = .abbreviated
		formatter.maximumUnitCount = 1

		return formatter.string(from: self.timeIntervalSince1970 - date.timeIntervalSince1970)!
	}

	public func abbreviatedFormat(from date: Date) -> String {
		return date.abbreviatedFormat(to: self)
	}
}

extension Date {

	public static func today() -> Date {
		return Date()
	}

	public func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
		return get(.next,
				   weekday,
				   considerToday: considerToday)
	}

	public func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
		return get(.previous,
				   weekday,
				   considerToday: considerToday)
	}

	public func get(_ direction: SearchDirection,
					_ weekDay: Weekday,
					considerToday consider: Bool = false) -> Date {

		let dayName = weekDay.rawValue

		let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

		assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

		let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

		let calendar = Calendar(identifier: .gregorian)

		if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
			return self
		}

		var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
		nextDateComponent.weekday = searchWeekdayIndex

		let date = calendar.nextDate(after: self,
									 matching: nextDateComponent,
									 matchingPolicy: .nextTime,
									 direction: direction.calendarSearchDirection)

		return date!
	}

	public func startOfDay() -> Date {
		return Calendar.current.startOfDay(for: self)
	}
}

// MARK: Helper methods
extension Date {
	public func getWeekDaysInEnglish() -> [String] {
		var calendar = Calendar(identifier: .gregorian)
		calendar.locale = Locale(identifier: "en_US_POSIX")
		return calendar.weekdaySymbols
	}

	public enum Weekday: String {
		case monday, tuesday, wednesday, thursday, friday, saturday, sunday
	}

	public enum SearchDirection {
		case next
		case previous

		public var calendarSearchDirection: Calendar.SearchDirection {
			switch self {
			case .next:
				return .forward
			case .previous:
				return .backward
			}
		}
	}
}

extension Date {
    public var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    public init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
