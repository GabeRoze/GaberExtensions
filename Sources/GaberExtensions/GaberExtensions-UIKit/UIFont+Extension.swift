//
//  File.swift
//  
//
//  Created by Gabe Rozenberg on 2023-07-09.
//

import Foundation
import UIKit

extension String {
    
    public func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
