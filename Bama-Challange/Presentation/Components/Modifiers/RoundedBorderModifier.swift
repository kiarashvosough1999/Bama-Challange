//
//  RoundedBorderModifier.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import SwiftUI

extension View {

    func roundBordered() -> some View {
        self.modifier(RoundedBorderModifier())
    }
}

private struct RoundedBorderModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue)
            }
    }
}

#if DEBUG
struct RoundedBorderModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .modifier(RoundedBorderModifier())
    }
}
#endif
