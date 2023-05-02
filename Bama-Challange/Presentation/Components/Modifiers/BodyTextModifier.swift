//
//  BodyTextModifier.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import SwiftUI

extension View {
    public func bodyTextStyle() -> some View {
        self.modifier(BodyTextModifier())
    }
}

private struct BodyTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .foregroundColor(.mint)
            .font(.body)
            .lineLimit(2)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct BodyTextModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .modifier(BodyTextModifier())
    }
}
#endif
