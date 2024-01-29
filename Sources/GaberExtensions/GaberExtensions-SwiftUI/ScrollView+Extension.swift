//
//  File.swift
//  
//
//  Created by Gabe Rozenberg on 2023-07-19.
//
// https://swiftwithmajid.com/2020/09/24/mastering-scrollview-in-swiftui/

import SwiftUI
import Introspect

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

public struct CustomScrollView<Content: View>: View {
    public let axes: Axis.Set
    public let showsIndicators: Bool
    public let offsetChanged: (CGPoint) -> Void
    public let content: Content
    
    public init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    public var body: some View {
        SwiftUI.ScrollView(axes, showsIndicators: showsIndicators) {
            GeometryReader { geometry in
                Color.clear.preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geometry.frame(in: .named("scrollView")).origin
                )
            }.frame(width: 0, height: 0)
            content
                
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}

final class ScrollDelegate: NSObject, UITableViewDelegate, UIScrollViewDelegate {
    var isScrolling: Binding<Bool>?
    var didEndDragging: ((Bool) -> ())?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let isScrolling = isScrolling?.wrappedValue,
           !isScrolling {
            DispatchQueue.main.async {
                self.isScrolling?.wrappedValue = true
            }
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let isScrolling = isScrolling?.wrappedValue, isScrolling {
            self.isScrolling?.wrappedValue = false
        }
    }
    // When the user slowly drags the scrollable control, decelerate is false after the user releases their finger, so the scrollViewDidEndDecelerating method is not called.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        didEndDragging?(decelerate)
        if !decelerate {
            if let isScrolling = isScrolling?.wrappedValue, isScrolling {
                self.isScrolling?.wrappedValue = false

            }
        }
    }
}
public extension View {
    func scrollStatusByIntrospect(isScrolling: Binding<Bool>) -> some View {
        modifier(ScrollStatusByIntrospectModifier(isScrolling: isScrolling))
    }
    
    func scrollDidEndDraggingByIntrospect(isScrolling: Binding<Bool>,
                                          didEndDragging: @escaping (Bool) -> ()) -> some View {
        modifier(ScrollStatusByIntrospectModifier(isScrolling: isScrolling,
                                                  didEndDragging: didEndDragging))
    }
}

public struct ScrollStatusByIntrospectModifier: ViewModifier {
    @State var delegate = ScrollDelegate()
    @Binding var isScrolling: Bool
    var didEndDragging: ((Bool) -> ())?
    public func body(content: Content) -> some View {
        content
            .onAppear {
                self.delegate.isScrolling = $isScrolling
                self.delegate.didEndDragging = didEndDragging
            }
        // Support ScrollView and List at the same time.
            .introspectScrollView { scrollView in
                scrollView.delegate = delegate
            }
            .introspectTableView { tableView in
                tableView.delegate = delegate
            }
    }
}
