//
//  PostView.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import SwiftUI

public struct PostView: View {

    private let title: String
    private let bodyText: String

    // MARK: - LifeCycle

    public init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
    }

    // MARK: - States

    @State private var isAppearing = false
    
    public var body: some View {
        VStack(spacing: 3) {
            Text(title)
                .titleTextStyle()

            Text(bodyText)
                .bodyTextStyle()
        }
        .animateOpacity()
        .padding(.all, 8)
        .roundBordered()
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(title: "test", bodyText: "test\ntest\ntest")
            .padding()
    }
}
#endif
