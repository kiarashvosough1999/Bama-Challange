//
//  PostListPageViewModel.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Foundation
import Dependencies

internal final class PostListPageViewModel: ObservableObject {

    internal struct PostItem: Identifiable, Hashable {
        internal let id: Int32
        internal let title: String
        internal let body: String
    }

    @Published internal var items: [PostItem]
    @Dependency(\.tapPostItemUseCase) private var tapPostItemUseCase
    @Dependency(\.fetchPostsUseCase) private var fetchPostsUseCase

    // MARK: - LifeCycle

    init() {
        self.items = []
    }

    @MainActor
    internal func load() async {
        do {
            self.items = try await fetchPostsUseCase.fetch().map {
                return PostItem(id: $0.id, title: $0.title, body: $0.body)
            }
        } catch {
            
        }
    }

    internal func onPostTapped(_ post: PostItem) {
        tapPostItemUseCase.postTapped(with: post.id)
    }
}
