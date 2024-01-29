//
//  File.swift
//  
//
//  Created by Gabe Rozenberg on 2023-08-02.
//

import SwiftUI
import Combine

extension View {
    public func limitText(_ field: Binding<String>, maxLength: Int) -> some View {
        modifier(TextLengthModifier(field: field, maxLength: maxLength))
    }
}

public struct TextLengthModifier: ViewModifier {
    @Binding var field: String
    let maxLength: Int
    
    public func body(content: Content) -> some View {
        content
            .onReceive(Just(field), perform: { _ in
                let updatedField = String(
                    field
                    // do other things here like limiting to number etc...
                        .enumerated()
                        .filter { $0.offset < maxLength }
                        .map { $0.element }
                )
                
                // ensure no infinite loop
                if updatedField != field {
                    field = updatedField
                }
            })
    }
}
