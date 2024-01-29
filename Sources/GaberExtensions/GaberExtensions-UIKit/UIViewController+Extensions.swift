//
//  UIViewControllerPreview+Extensions.swift
// App-iOS
//
//  Created by Rohan Parikh on 8/17/22.
//

import Foundation
import SwiftUI

// 1
@available(iOS 13.0, *)
extension UIViewController {
    
    // 2
    private struct Preview: UIViewControllerRepresentable {
        
        // 3
        let viewController: UIViewController
        
        // 4
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    
    // 5
    public var preview: some View {
        return Preview(viewController: self)
    }
}
