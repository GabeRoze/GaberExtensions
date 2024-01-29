//
//  NavigationLink+Extensions.swift
//  GabeR
//
//  Created by Gabriel Rozenberg on 12/10/21.
// Copyright (c) 2022 Gabriel Rozenberg. All Rights reserved.
//

import SwiftUI

extension NavigationLink {

    public init<Value, WrappedDestination>(
        unwrap optionalValue: Binding<Value?>,
        onNavigate: @escaping (Bool) -> Void,
        @ViewBuilder destination: @escaping (Binding<Value>) -> WrappedDestination,
        @ViewBuilder label: () -> Label)
    where Destination == WrappedDestination? {
        self.init(isActive: optionalValue.isPresent().didSet(onNavigate),
                  destination: {
                        if let value = Binding(unwrap: optionalValue) {
                            destination(value)
                        }
                    },
                  label: label
        )
    }
}

public struct NavigationLinkViewPresentationModifier<Label: View, Destination: View>: ViewModifier {

    @Binding public var isPresented: Bool
    public var destination: () -> Destination
    public var label: () -> Label

    init(isPresented: Binding<Bool>,
         destination: @escaping () -> Destination,
         label: @escaping () -> Label) {
        _isPresented = isPresented
        self.destination = destination
        self.label = label
    }

    public func body(content: Content) -> some View {
        content.background(
            NavigationLink(isActive: $isPresented,
                           destination: destination,
                           label: label)
        )
    }
}

public struct NavigationLinkItemViewPresentationModifier<Item, Label: View, Destination: View>: ViewModifier {

    public var item: Binding<Item?>
    public var onNavigate: (Bool) -> Void
    public var destination: (Binding<Item>) -> Destination
    public var label: () -> Label

    public init(item: Binding<Item?>,
         onNavigate: @escaping (Bool) -> Void,
         destination: @escaping (Binding<Item>) -> Destination,
         label: @escaping () -> Label) {
        self.item = item
        self.onNavigate = onNavigate
        self.destination = destination
        self.label = label
    }

    public func body(content: Content) -> some View {
        content.background(
            NavigationLink(unwrap: item,
                           onNavigate: onNavigate,
                           destination: destination,
                           label: label)
        )
    }
}

public extension View {

    func navigationLink<Label: View, Destination: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder destination: @escaping () -> Destination,
        @ViewBuilder label: @escaping () -> Label) -> some View {
        self.modifier(
            NavigationLinkViewPresentationModifier(
                isPresented: isPresented,
                destination: destination,
                label: label
            )
        )
    }

    func navigationLink<Item, Label: View, Destination: View>(
        item: Binding<Item?>,
        onNavigate: @escaping (Bool) -> Void,
        @ViewBuilder destination: @escaping (Binding<Item>) -> Destination,
        @ViewBuilder label: @escaping () -> Label) -> some View {
        self.modifier(
            NavigationLinkItemViewPresentationModifier(
                item: item,
                onNavigate: onNavigate,
                destination: destination,
                label: label
            )
        )
    }
}
