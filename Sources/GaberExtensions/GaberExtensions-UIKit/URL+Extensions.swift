//
//  URL+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 4/16/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit
import AVFoundation

public struct UTMParamters {
    let source: String?
    let campaign: String?
    let term: String?
    let medium: String?
    let content: String?
}

extension URL {

	public init?(string: String?) {
        guard let string = string else {
            return nil
        }

        self.init(string: string)
    }

	public func getThumbnailImageFromVideoURL() -> UIImage? {
        let asset: AVAsset = AVAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            debugPrint(error)
        }

        return nil
    }

	public var queryDictionary: [String: String]? {
        guard let query = self.query else { return nil}

        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {

            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                                .components(separatedBy: "=")[1]
                                .replacingOccurrences(of: "+", with: " ")
                                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        return queryStrings
    }

	public func normalizeSearchParamSpaceEncoding() -> URL? {
        return URL(string: self.absoluteString.replacingOccurrences(of: "+", with: "%20"))
    }
    
    /// Appends a news query items to an existing URL
    /// - parameters:
    ///   - queryItems: The `URLQueryItem` collection to append
    /// - returns: A new URL with the provided query items or nil if the appending failed
    public func appending(queryItems: [URLQueryItem]) -> URL? {
      var urlComponents = URLComponents(string: absoluteString)

      if urlComponents?.queryItems != nil {
        urlComponents?.queryItems?.merge(queryItems)
      } else {
        urlComponents?.queryItems = queryItems
      }

      return urlComponents?.url
    }
    
    public var cacheKey: String {
        return self.absoluteString
    }
}

// The following is sourced from stackoverflow
// https://stackoverflow.com/questions/46603220/how-do-i-convert-url-query-to-a-dictionary-in-swift
extension URL {
	public func toQueryItems() -> [URLQueryItem]? { return URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems }
}

// MARK: - [URLQueryItem] to [String: Any]
extension Array where Element == URLQueryItem {
	public func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        for queryItem in self {
            guard let value = queryItem.value?.toCorrectType() else { continue }
            if queryItem.name.contains("[]") {
                let key = queryItem.name.replacingOccurrences(of: "[]", with: "")
                let array = dictionary[key] as? [Any] ?? []
                dictionary[key] = array + [value]
            } else {
                dictionary[queryItem.name] = value
            }
        }
        return dictionary
    }
}

extension String {

    // MARK: - String to [URLQueryItem]
	public func toURLQueryItems() -> [URLQueryItem]? {
        guard let urlString = self.removingPercentEncoding, let url = URL(string: urlString) else { return nil }
        if let querItems = url.toQueryItems() { return querItems }
        var urlComponents = URLComponents()
        urlComponents.query = urlString
        return urlComponents.queryItems
    }

    // MARK: - attempt to cast string to correct type (int, bool...)
	public func toCorrectType() -> Any {
        let types: [LosslessStringConvertible.Type] = [Bool.self, Int.self, Double.self]
        func cast<T>(to: T) -> Any? { return (to.self as? LosslessStringConvertible.Type)?.init(self) }
        for type in types { if let value = cast(to: type) { return value } }
        return self
    }
}

extension URL {
    
	public var utms: UTMParamters? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }

        return UTMParamters(
            source: components.queryItemValue(for: "utm_source"),
            campaign: components.queryItemValue(for: "utm_campaign"),
            term: components.queryItemValue(for: "utm_term"),
            medium: components.queryItemValue(for: "utm_medium"),
            content: components.queryItemValue(for: "utm_content")
        )
    }
}

#endif
