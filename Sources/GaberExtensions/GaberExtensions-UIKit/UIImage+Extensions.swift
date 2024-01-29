//
//  UIImage+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 5/18/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit
import AVFoundation
import CoreImage
import CoreGraphics
import Accelerate.vImage

extension UIImage {

    public func grayscaleImage() -> UIImage? {
        if let ciImage = CIImage(image: self) {
            let grayscale = ciImage.applyingFilter("CIColorControls",
                                                   parameters: [kCIInputSaturationKey: 0.0])
            return UIImage(ciImage: grayscale)
        }
        return nil
    }

	public static func generateThumbnailFromAsset(asset: AVAsset, forTime time: CMTime) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        var actualTime: CMTime = CMTime.zero
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: &actualTime)
            let image = UIImage(cgImage: imageRef)
            return image
        } catch let error as NSError {
            print("\(error.description). Time: \(actualTime)")
            return nil
        }
    }

	public static var defaultImage: UIImage {
        return UIImage(imageLiteralResourceName: "default.thumbnail")
    }

	public func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image// .withRenderingMode(self.renderingMode)
    }

    //https://stackoverflow.com/questions/29046571/cut-a-uiimage-into-a-circle/29046647
	public var isPortrait: Bool { size.height > size.width }
	public var isLandscape: Bool { size.width > size.height }
	public var breadth: CGFloat { min(size.width, size.height) }
	public var breadthSize: CGSize { .init(width: breadth, height: breadth) }
	public var breadthRect: CGRect { .init(origin: .zero, size: breadthSize) }
	public var circleMasked: UIImage? {
        guard let cgImage = cgImage?
                .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                                  y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                    size: breadthSize)) else { return nil }
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
            UIBezierPath(ovalIn: breadthRect).addClip()
            UIImage(cgImage: cgImage, scale: format.scale, orientation: imageOrientation)
                    .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }
}


extension UIImage {
	public func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
		// Determine the scale factor that preserves aspect ratio
		let widthRatio = targetSize.width / size.width
		let heightRatio = targetSize.height / size.height
		
		let scaleFactor = min(widthRatio, heightRatio)
		
		// Compute the new image size that preserves aspect ratio
		let scaledImageSize = CGSize(
			width: size.width * scaleFactor,
			height: size.height * scaleFactor
		)
		
		// Draw and return the resized UIImage
		let renderer = UIGraphicsImageRenderer(
			size: scaledImageSize
		)
		
		let scaledImage = renderer.image { _ in
			self.draw(in: CGRect(
				origin: .zero,
				size: scaledImageSize
			))
		}
		
		return scaledImage
	}
	
	public func resize(size: CGSize) -> UIImage? {
		
		guard let cgImage = self.cgImage else { return nil}
		
		var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil,
										  bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
										  version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
		var sourceBuffer = vImage_Buffer()
		defer {
			if #available(iOS 13.0, *) {
				sourceBuffer.free()
			} else {
				sourceBuffer.data.deallocate()
			}
		}
		
		var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
		guard error == kvImageNoError else { return nil }
		
		// create a destination buffer
		let scale = self.scale
		let destWidth = Int(size.width)
		let destHeight = Int(size.height)
		let bytesPerPixel = cgImage.bitsPerPixel / 8
		let destBytesPerRow = destWidth * bytesPerPixel
		let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
		defer {
			destData.deallocate()
		}
		var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
		
		// scale the image
		error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
		guard error == kvImageNoError else { return nil }
		
		// create a CGImage from vImage_Buffer
		guard let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue() else { return nil}
		guard error == kvImageNoError else { return nil }
		
		// create a UIImage
		let resizedImage = UIImage(cgImage: destCGImage, scale: scale, orientation: self.imageOrientation)
		return resizedImage
	}
}


#endif
