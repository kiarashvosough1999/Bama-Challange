//
//  TitleTextModifier.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import SwiftUI

extension View {
    public func titleTextStyle() -> some View {
        self.modifier(TitleTextModifier())
    }
}

private struct TitleTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .truncationMode(.tail)
            .foregroundColor(.cyan)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct TitleTextModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .modifier(TitleTextModifier())
    }
}
#endif
