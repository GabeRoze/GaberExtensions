//
// Created by Gabriel Rozenberg on 2021-12-06.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

extension UIStackView {
	
	public func addHStack(distribution: UIStackView.Distribution = .fill,
						  alignment: UIStackView.Alignment = .fill,
						  spacing: CGFloat = 0,
						  color: UIColor = .clear,
						  height: CGFloat = 0,
						  leftConstant: CGFloat = 0,
						  rightConstant: CGFloat = 0) -> UIStackView {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = distribution
		stack.alignment = alignment
		stack.spacing = spacing
		stack.backgroundColor = color
		addArrangedSubview(stack)
		
		if height > 0 {
			stack.layout([.left(to: self.leftAnchor, constant: leftConstant),
						  .right(to: self.rightAnchor, constant: rightConstant),
						  .height(constant: height)])
		} else {
			stack.layout([.left(to: self.leftAnchor, constant: leftConstant),
						  .right(to: self.rightAnchor, constant: rightConstant)])
		}
		return stack
	}
	
	@discardableResult
	public func addLabel(color: UIColor,
						font: UIFont,
						height: CGFloat = 0,
						leftConstant: CGFloat = 0,
						rightConstant: CGFloat = 0,
						minimumScaleFactor: CGFloat = 0.5,
						numberOfLines: Int = 1,
						text: String) -> UILabel {
		let label = UILabel()
		addArrangedSubview(label)
		
		if height > 0 {
			label.layout([.left(to: self.leftAnchor, constant: leftConstant),
						  .right(to: self.rightAnchor, constant: rightConstant),
						  .height(constant: height)])
		} else {
			label.layout([.left(to: self.leftAnchor, constant: leftConstant),
						  .right(to: self.rightAnchor, constant: rightConstant)])
		}
		label.font = font
		label.textColor = color
		label.text = text
		label.minimumScaleFactor = minimumScaleFactor
		label.adjustsFontSizeToFitWidth = true
		label.numberOfLines = numberOfLines
		return label
	}
	
	public func addButton(
		text: String,
		image: UIImage? = nil,
		titleColor: UIColor,
		backgroundColor: UIColor = .clear,
		font: UIFont,
		height: CGFloat = 0,
		leftConstant: CGFloat = 0,
		rightConstant: CGFloat = 0,
		minimumScaleFactor: CGFloat = 0.5) -> UIButton {
			let button = UIButton()
			addArrangedSubview(button)
			
			if height > 0 {
				button.layout([.left(to: self.leftAnchor, constant: leftConstant),
							   .right(to: self.rightAnchor, constant: rightConstant),
							   .height(constant: height)])
			} else {
				button.layout([.left(to: self.leftAnchor, constant: leftConstant),
							   .right(to: self.rightAnchor, constant: rightConstant)])
			}
			button.backgroundColor = backgroundColor
			button.titleLabel?.font = font
			button.setImage(image, for: .normal)
			button.setTitleColor(titleColor, for: .normal)
			button.setTitle(text, for: .normal)
			button.titleLabel?.minimumScaleFactor = minimumScaleFactor
			button.titleLabel?.adjustsFontSizeToFitWidth = true
			
			return button
		}
	
	public func addSizedButton(
		text: String,
		image: UIImage? = nil,
		titleColor: UIColor,
		backgroundColor: UIColor = .clear,
		font: UIFont,
		//			width: CGFloat = 0,
		height: CGFloat,
		minimumScaleFactor: CGFloat = 0.5,
		leftConstant: CGFloat = 0,
		rightConstant: CGFloat = 0
	) -> UIButton {
		let button = UIButton()
		addArrangedSubview(button)
		
		button.layout([
			.left(to: leftAnchor, constant: leftConstant),
			.right(to: rightAnchor, constant: rightConstant),
			//						  .width(constant: width),
			.height(constant: height)])
		button.backgroundColor = backgroundColor
		button.titleLabel?.font = font
		button.setImage(image, for: .normal)
		button.setTitleColor(titleColor, for: .normal)
		button.setTitle(text, for: .normal)
		button.titleLabel?.minimumScaleFactor = minimumScaleFactor
		button.titleLabel?.adjustsFontSizeToFitWidth = true
		
		return button
	}
	
	@discardableResult
	public func addView(color: UIColor,
						height: CGFloat,
						leftConstant: CGFloat = 0,
						rightConstant: CGFloat = 0) -> UIView {
		
		let view = UIView()
		view.backgroundColor = color
		addArrangedSubview(view)
		view.layout([.left(to: leftAnchor, constant: leftConstant),
					 .right(to: rightAnchor, constant: rightConstant),
					 .height(constant: height)])
		return view
	}
}

#endif
