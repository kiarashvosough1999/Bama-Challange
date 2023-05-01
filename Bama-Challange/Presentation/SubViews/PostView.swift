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

    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
    }

    @State private var isAppearing = false
    
    public var body: some View {
        VStack(spacing: 3) {
            Text(title)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundColor(.cyan)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(bodyText)
                .foregroundColor(.mint)
                .font(.body)
                .lineLimit(2)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .opacity(isAppearing ? 1 : 0)
        .animation(.easeInOut(duration: 0.6), value: isAppearing)
        .padding(.all, 8)
        .onAppear {
            isAppearing = true
        }
        .onDisappear {
            isAppearing = false
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(.blue)
        }
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(title: "dasdad", bodyText: "dsadasdad")
            .padding()
    }
}
#endif
