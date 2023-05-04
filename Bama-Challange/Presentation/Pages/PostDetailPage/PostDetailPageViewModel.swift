//
//  PostDetailPageViewModel.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import Foundation
import Dependencies

internal final class PostDetailPageViewModel: ObservableObject {

    @Published internal var post: PageLoadState<PostDetailModel> = .loading
    @Dependency(\.persistPostIdMessageQueueService) private var persistPostIdMessageBrokerService
    @Dependency(\.fetchPostsUseCase) private var fetchPostsUseCase

    @MainActor
    internal func load() async {
        if let id = persistPostIdMessageBrokerService.retreivePostId() {
            do {
                let entity = try await fetchPostsUseCase.fetch(with: id)

                let loadedPost = PostDetailModel(
                    id: "\(entity.id)",
                    title: entity.title,
                    body: entity.body,
                    userId: "\(entity.userId)"
                )
                self.post = .loaded(loadedPost)
            } catch {
                self.post = .failed(message: "Failed To Load")
            }
        } else {
            self.post = .failed(message: "Invalid Post")
        }
    }
}

extension PostDetailPageViewModel {

    internal struct PostDetailModel: Equatable {
        internal var id: String
        internal var title: String
        internal var body: String
        internal var userId: String
    }
}
