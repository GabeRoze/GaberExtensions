//
//  JSONRepresentable.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 2/3/22.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

public protocol JSONRepresentable {
    var JSONRepresentation: Any { get }
}

public protocol JSONSerializable: JSONRepresentable {}

//: ### Implementing the functionality through protocol extensions
extension JSONSerializable {
	public var JSONRepresentation: Any {
        var representation = [String: Any]()

        for case let (label?, value) in Mirror(reflecting: self).children {

            switch value {

            case let value as [String: Any]:
                representation[label] = value as AnyObject

            case let value as [Any]:
                if let val = value as? [JSONSerializable] {
                    representation[label] = val.map({ $0.JSONRepresentation as AnyObject }) as AnyObject
                } else {
                    representation[label] = value as AnyObject
                }

            case let value:
                representation[label] = value as AnyObject
            }
        }
        return representation as Any
    }
}

extension JSONSerializable {
	public func toJSON() -> String? {
        let representation = JSONRepresentation

        guard JSONSerialization.isValidJSONObject(representation) else {
            print("Invalid JSON Representation")
            return nil
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])

            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }

	public func toJSONData() -> Data? {
        let representation = JSONRepresentation

        guard JSONSerialization.isValidJSONObject(representation) else {
            print("Invalid JSON Representation")
            return nil
        }

        return try? JSONSerialization.data(withJSONObject: representation, options: [])
    }
}
