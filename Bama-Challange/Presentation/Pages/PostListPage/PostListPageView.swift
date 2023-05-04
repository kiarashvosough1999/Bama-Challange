//
//  PostListPageView.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import SwiftUI

public struct PostListPageView: View {

    @StateObject private var viewModel = PostListPageViewModel()

    public var body: some View {
        ScrollView {
            WithLoadingState(state: viewModel.posts) { posts in
                LazyVStack {
                    ForEach(posts) { item in
                        PostView(
                            title: item.title,
                            bodyText: item.body
                        )
                            .padding(.all, 10)
                            .onTapGesture {
                                viewModel.onPostTapped(item)
                            }
                    }
                }
            }
            .onRetry {
                await self.viewModel.load()
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#if DEBUG
struct PostListPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostListPageView()
    }
}
#endif
