//
//  String+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 5/23/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension String {

    public func startingAtIndex(_ index: Int) -> String{
        let start = self.index(startIndex, offsetBy: index)
        let end = endIndex
        let range = start..<end

        return String(self[range])
    }

    // from https://blog.devgenius.io/regex-text-validator-in-swift-43864103feca
    public func validate(with regex: String) -> Bool {
        // Create the regex
        guard let gRegex = try? NSRegularExpression(pattern: regex) else {
            return false
        }

        // Create the range
        let range = NSRange(location: 0, length: utf16.count)

        // Perform the test
        if gRegex.firstMatch(in: self, options: [], range: range) != nil {
            return true
        }

        return false
    }

    public var isInt: Bool {
        return Int(self) != nil
    }

	public func isValidString() -> Bool {
        if self.count > 0 {
            return true
        }
        return false
    }

    public func getNSRange(start: String.Index, end: String.Index) -> NSRange {
        return NSRange(startIndex..<end, in: self)
    }

	public var fullNSRange: NSRange {
        return NSRange(startIndex..<endIndex, in: self)
    }
	public var fullRange: Range<String.Index> { return startIndex..<endIndex }

	public func firstWord() -> String {
        return self.components(separatedBy: .whitespaces).first ?? ""
    }

	public func rangeOfNthWords(amount: Int) -> Range<String.Index>? {
        guard amount != 0 else {
            return self.range(of: self)
        }
        let components = self.components(separatedBy: .whitespaces)
        guard components.count > amount - 1 else { return nil }
        let lastWord = components[amount - 1]

        if let range = self.range(of: lastWord), let wholeRange = self.range(of: self) {
            return Range<String.Index>.init(uncheckedBounds: (lower: wholeRange.lowerBound, upper: range.upperBound))
        }

        return nil
    }

	public mutating func removeFirstWord() -> String {
        var word = ""
        var string = self
        while !string.isEmpty {
            let character = string.removeFirst()
            let scalar = character.unicodeScalars.first!
            if CharacterSet.whitespaces.contains(scalar) {
                break
            }
            word.append(character)
        }

        self = string
        return word
    }

	public func json() -> Any? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}

extension String {

	public static func dayOfWeek(_ index: Int) -> String {
        switch index {
        case 0: return "Monday"
        case 1: return "Tuesday"
        case 2: return "Wednesday"
        case 3: return "Thursday"
        case 4: return "Friday"
        case 5: return "Saturday"
        case 6: return "Sunday"
        default: return "Monday"
        }
    }

	public static func letterOfDay(_ index: Int) -> String {
        switch index {
        case 0: return "M"
        case 1: return "T"
        case 2: return "W"
        case 3: return "T"
        case 4: return "F"
        case 5: return "S"
        case 6: return "S"
        default: return "M"
        }
    }
}

//import UIKit

extension RangeExpression where Bound == String.Index {
	public func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}

extension String {
	public func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
		var ranges: [Range<Index>] = []
		while ranges.last.map({ $0.upperBound < self.endIndex }) ?? true,
			  let range = self.range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
			ranges.append(range)
		}
		return ranges
	}
}


extension String {

	public func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

// from https://stackoverflow.com/questions/43233070/how-to-convert-range-in-nsrange
extension StringProtocol {
	public func nsRange<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        self.range(of: string,
                   options: options,
                   range: range ?? startIndex..<endIndex,
                   locale: locale ?? .current)?
                .nsRange(in: self)
    }
	public func nsRanges<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end,
              let range = self.range(of: string,
                                     options: options,
                                     range: start..<end,
                                     locale: locale ?? .current) {
            ranges.append(range.nsRange(in: self))
            start = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return ranges
    }
}

extension String {
	public subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
