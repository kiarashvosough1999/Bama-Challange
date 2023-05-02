//
//  PostDetailPageViewModel.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import Foundation
import Dependencies

internal final class PostDetailPageViewModel: ObservableObject {

    @Published internal var post: PostDetailModel?
    @Dependency(\.persistPostIdMessageQueueService) private var persistPostIdMessageBrokerService
    @Dependency(\.fetchPostsUseCase) private var fetchPostsUseCase

    internal init() {
        Task {
            await self.load()
        }
    }

    private func load() async {
        if let id = persistPostIdMessageBrokerService.retreivePostId() {
            do {
                let entity = try await fetchPostsUseCase.fetch(with: id)

                self.post = PostDetailModel(
                    id: "\(entity.id)",
                    title: entity.title,
                    body: entity.body,
                    userId: "\(entity.userId)"
                )
            } catch {
                
            }
        } else {
            
        }
    }
}

extension PostDetailPageViewModel {

    internal struct PostDetailModel {
        internal var id: String
        internal var title: String
        internal var body: String
        internal var userId: String
    }
}
