//
//  OpacityAnimationModifier.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import SwiftUI

extension View {

    public func animateOpacity() -> some View {
        self.modifier(OpacityAnimationModifier())
    }
}

private struct OpacityAnimationModifier: ViewModifier {

    @State private var isAppearing = false

    func body(content: Content) -> some View {
        content
            .opacity(isAppearing ? 1 : 0)
            .animation(.easeInOut(duration: 0.6), value: isAppearing)
            .onAppear {
                isAppearing = true
            }
            .onDisappear {
                isAppearing = false
            }
    }
}

#if DEBUG
struct OpacityAnimationModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .modifier(OpacityAnimationModifier())
    }
}
#endif
