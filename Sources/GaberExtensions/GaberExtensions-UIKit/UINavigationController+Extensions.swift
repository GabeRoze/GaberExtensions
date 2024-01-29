//
//  UINavigationController+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 3/28/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import UIKit

extension UINavigationController {

  public func pushViewController(viewController: UIViewController,
                                 animated: Bool,
                                 completion: (() -> Void)?) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }

}

#endif
