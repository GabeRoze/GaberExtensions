//
// Created by Gabriel Rozenberg on 2022-07-15
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

//extension RangeExpression where Bound == String.Index {
//	func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
//}
//
//extension String {
//	func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
//		var ranges: [Range<Index>] = []
//		while ranges.last.map({ $0.upperBound < self.endIndex }) ?? true,
//			  let range = self.range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
//			ranges.append(range)
//		}
//		return ranges
//	}
//}

extension NSMutableAttributedString {
    public var fontSize: CGFloat { 16 }
    public var boldFont: UIFont { UIFont.systemFont(ofSize: fontSize, weight: .bold) }
    public var normalFont: UIFont { UIFont.systemFont(ofSize: fontSize, weight: .regular) }

    public func boldExisting(_ value: String, fontSize: CGFloat) -> NSMutableAttributedString {

		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)
		]

		for range in self.string.ranges(of: value).map({ $0.nsRange(in: self.string) }) {
			self.addAttributes(attributes, range: range)
		}

		return self
	}

	public func changeFontColorExisting(_ value: String, foregroundColor: UIColor) -> NSMutableAttributedString {

		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: foregroundColor
		]

		for range in self.string.ranges(of: value).map({ $0.nsRange(in: self.string) }) {
			self.addAttributes(attributes, range: range)
		}

		return self
	}

    public func bold(_ value: String) -> NSMutableAttributedString {

		let attributes: [NSAttributedString.Key: Any] = [
			.font: boldFont
		]

		self.append(NSAttributedString(string: value, attributes: attributes))
		return self
	}

    public func normal(_ value: String) -> NSMutableAttributedString {

		let attributes: [NSAttributedString.Key: Any] = [
			.font: normalFont
		]

		self.append(NSAttributedString(string: value, attributes: attributes))
		return self
	}

	/* Other styling methods */
    public func orangeHighlight(_ value: String) -> NSMutableAttributedString {

		let attributes: [NSAttributedString.Key: Any] = [
			.font: normalFont,
			.foregroundColor: UIColor.white,
			.backgroundColor: UIColor.orange
		]

		self.append(NSAttributedString(string: value, attributes: attributes))
		return self
	}

    public func blackHighlight(_ value: String) -> NSMutableAttributedString {

		let attributes: [NSAttributedString.Key: Any] = [
			.font: normalFont,
			.foregroundColor: UIColor.white,
			.backgroundColor: UIColor.black

		]

		self.append(NSAttributedString(string: value, attributes: attributes))
		return self
	}

    public func underlined(_ value: String) -> NSMutableAttributedString {

		let attributes: [NSAttributedString.Key: Any] = [
			.font: normalFont,
			.underlineStyle: NSUnderlineStyle.single.rawValue

		]

		self.append(NSAttributedString(string: value, attributes: attributes))
		return self
	}

    public func addAttributeToSubstring(_ substring: String, _ attribute: [Key: Any]) -> NSMutableAttributedString {
		let selfStr = self.string
		if let nsRange = selfStr.nsRange(of: substring) {
			self.addAttributes(attribute, range: nsRange)
		}
		return self
	}
}

extension NSAttributedString {
    public func textToImage() -> UIImage {
		return UIGraphicsImageRenderer(size: size()).image { _ in
			self.draw(at: .zero)
		}
	}
}

#endif
