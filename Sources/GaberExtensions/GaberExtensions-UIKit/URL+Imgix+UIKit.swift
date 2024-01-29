//
//  File.swift
//  
//
//  Created by Gabriel Rozenberg on 2022-05-27.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

extension URL {
	
	public func with(size: CGSize, cornerRadius: CGFloat = 0, scale: CGFloat = UIScreen.main.scale, fit: FitMode = .min, type: ImageType? = .png, saturation: Int? = nil, borderWidth: CGFloat? = nil, borderColor: String = "000000" ) -> URL {
		
		return self.with(width: size.width,
						 height: size.height,
						 cornerRadius: cornerRadius,
						 scale: scale,
						 fit: fit,
						 type: type,
						 saturation: saturation,
						 borderWidth: borderWidth,
						 borderColor: borderColor)
	}
	
	public func with(width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: CGFloat = 0, scale: CGFloat = UIScreen.main.scale, fit: FitMode = .min, type: ImageType? = .png, saturation: Int? = nil, borderWidth: CGFloat? = nil, borderColor: String = "000000" ) -> URL {
		
		let cornerRadius = cornerRadius * scale
		
		var urlComps = URLComponents(string: self.absoluteString)!
		var queryItems = urlComps.queryItems ?? []
		queryItems.append(URLQueryItem(name: "fit", value: fit.rawValue))
		queryItems.append(URLQueryItem(name: "auto", value: "compress"))
		
		if let width = width {
			queryItems.append(URLQueryItem(name: "w", value: "\(width*scale)"))
		}
		
		if let height = height {
			queryItems.append(URLQueryItem(name: "h", value: "\(height*scale)"))
		}
		
		if let type = type {
			queryItems.append(URLQueryItem(name: "fm", value: type.rawValue))
		}
		
		if let sat = saturation {
			queryItems.append(URLQueryItem(name: "sat", value: "\(sat)"))
		}
		
		if cornerRadius != 0 {
			queryItems.append(contentsOf: [URLQueryItem(name: "mask", value: "corners"),
										   URLQueryItem(name: "corner-radius", value: "\(cornerRadius)")])
		}
		
		if let borderWidth = borderWidth {
			queryItems.append(contentsOf: [URLQueryItem(name: "border", value: "\(borderWidth),\(borderColor)")])
			// URLQueryItem(name: "border-radius", value: "\(cornerRadius)")
		}
		
		urlComps.queryItems = queryItems
		let url = urlComps.url!
		return url
	}
}

#endif
