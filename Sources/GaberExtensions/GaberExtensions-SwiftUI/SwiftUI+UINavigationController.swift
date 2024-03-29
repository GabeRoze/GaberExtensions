//
//  File.swift
//  
//
//  Created by Gabe Rozenberg on 2024-02-02.
//

import SwiftUI
import UIKit

// from https://stackoverflow.com/a/62785462
extension View {
    public func configureNavigationBar(configure: @escaping (UINavigationController) -> Void) -> some View {
        modifier(NavigationConfigurationViewModifier(configure: configure))
    }
}

public struct NavigationConfigurationViewModifier: ViewModifier {
    public let configure: (UINavigationController) -> Void
    public init(configure: @escaping (UINavigationController) -> Void) {
        self.configure = configure
    }
    public func body(content: Content) -> some View {
        content.background(NavigationConfigurator(configure: configure))
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    public let configure: (UINavigationController) -> Void
    
    public func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfigurator>
    ) -> NavigationConfigurationViewController {
        NavigationConfigurationViewController(configure: configure)
    }
    
    public func updateUIViewController(
        _ uiViewController: NavigationConfigurationViewController,
        context: UIViewControllerRepresentableContext<NavigationConfigurator>
    ) { }
}

final class NavigationConfigurationViewController: UIViewController {
    public let configure: (UINavigationController) -> Void
    
    public init(configure: @escaping (UINavigationController) -> Void) {
        self.configure = configure
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(_: animated)
        
        if let navigationController = navigationController {
            configure(navigationController)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navigationController = navigationController {
            configure(navigationController)
        }
    }
}

