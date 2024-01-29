//
// Created by Gabriel Rozenberg on 2021-12-08.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import Foundation

extension URLRequest {
	public func cURL(pretty: Bool = false) -> NSString {
		let newLine = pretty ? "\\\n" : ""
		let method = (pretty ? "--request " : "-X ") + "\(httpMethod ?? "GET") \(newLine)"
		let url: String = (pretty ? "--url " : "") + "\'\(url?.absoluteString ?? "")\' \(newLine)"
		var cURL = "curl "
		var header = ""
		var data: String = ""
		if let httpHeaders = allHTTPHeaderFields, httpHeaders.keys.count > 0 {
			for (key, value) in httpHeaders {
				header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
			}
		}
		if let bodyData = httpBody, let bodyString = String(data: bodyData, encoding: .utf8), !bodyString.isEmpty {
			data = "--data '\(bodyString)'"
		}
		cURL += method + url + header + data
		return NSString(string: cURL)
	}
}
