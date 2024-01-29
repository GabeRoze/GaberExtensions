//
//  UILabel+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 5/23/20.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

extension UILabel {

	public func generateAttributedText() -> NSAttributedString {
        return self.attributedText ?? NSAttributedString(string: self.text ?? "", attributes: [.font: font ?? UIFont.systemFont(ofSize: 14), .foregroundColor: self.textColor ?? .black])
    }

	public func kern(_ value: CGFloat) {
        let attributedText = generateAttributedText()

        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)

        mutableAttributedText.addAttribute(.kern, value: value, range: mutableAttributedText.string.fullNSRange)

        self.attributedText = mutableAttributedText
    }

	public func highlight(_ word: String, _ color: UIColor) {
        let attributedText = generateAttributedText()

        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)

        if let range = mutableAttributedText.string.range(of: word) {
            let nsRange = NSRange(range, in: mutableAttributedText.string)
            mutableAttributedText.addAttribute(.foregroundColor, value: color, range: nsRange)
            self.attributedText = mutableAttributedText
        }
    }

	public func lineHeightMultiple(_ value: CGFloat) {
        let attributedText = generateAttributedText()

        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = value
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = self.lineBreakMode

        mutableAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: mutableAttributedText.string.fullNSRange)

        self.attributedText = mutableAttributedText
    }

	public func lineSpacing(_ value: CGFloat) {
        let attributedText = generateAttributedText()

        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = value
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = self.lineBreakMode

        mutableAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: mutableAttributedText.string.fullNSRange)

        self.attributedText = mutableAttributedText
    }
}

extension UITapGestureRecognizer {
	public func didTapAttributedTextInLabel(label: UILabel, targetText: String) -> Bool {
        guard let attributedString = label.attributedText, let lblText = label.text else { return false }
        let targetRange = (lblText as NSString).range(of: targetText)
        // IMPORTANT label correct font for NSTextStorage needed
        let mutableAttribString = NSMutableAttributedString(attributedString: attributedString)
        mutableAttribString.addAttributes(
            [NSAttributedString.Key.font: label.font ?? UIFont.smallSystemFontSize],
            range: NSRange(location: 0, length: attributedString.length)
        )
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: mutableAttribString)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y:
            locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

#endif
