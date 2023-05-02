//
//  PostDetailPageView.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import SwiftUI

public struct PostDetailPageView: View {

    @StateObject private var viewModel: PostDetailPageViewModel = PostDetailPageViewModel()

    public var body: some View {
        if let post = viewModel.post {
            Form {
                Section("Ids") {
                    TitleValueFormRow(title: "Id", value: post.id)
                    TitleValueFormRow(title: "User-Id", value: post.userId)
                }

                Section("Content") {
                    TitleValueFormRow(title: "Title", value: post.title)
                    TitleValueFormRow(title: "Body", value: post.body)
                }
            }
        }
    }
}

#if DEBUG
struct PostDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailPageView()
    }
}
#endif
