//
//  EmptyTabViewModifier.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/4/23.
//

import SwiftUI

extension View {

    public func fixEmptyTabView() -> some View {
        self.modifier(EmptyTabViewModifier())
    }
}

private struct EmptyTabViewModifier: ViewModifier {

    fileprivate func body(content: Content) -> some View {
        ZStack {
            EmptyView()
            content
        }
    }
}
