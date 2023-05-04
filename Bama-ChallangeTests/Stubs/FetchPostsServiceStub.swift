//
//  FetchPostsServiceStub.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import Foundation
import Bama_Challange
import XCTest

struct FetchPostsServiceStub: Mock {

    enum Action: Equatable {
        case fetchPost(Int32)
    }

    let actions: MockActions<Action>
    
    private let posts: [PostListItem]!
    private let post: PostListItem!
    private let fetchPostsError: Error!
    private let fetchPostError: Error!

    init(
        actions: MockActions<Action> = .init(expected: []),
        posts: [PostListItem]? = nil,
        post: PostListItem? = nil,
        fetchPostsError: Error? = nil,
        fetchPostError: Error? = nil
    ) {
        self.actions = actions
        self.posts = posts
        self.post = post
        self.fetchPostsError = fetchPostsError
        self.fetchPostError = fetchPostError
    }
}

extension FetchPostsServiceStub: FetchPostsServiceProtocol {

    func fetchPosts() async throws -> [PostListItem] {
        if let posts {
            return posts
        } else if let fetchPostsError {
            throw fetchPostsError
        } else {
            throw MockError.unimplemented
        }
    }
    
    func fetchPost(with id: Int32) async throws -> PostListItem {
        actions.register(.fetchPost(id))
        if let post {
            return post
        } else if let fetchPostError {
            throw fetchPostError
        } else {
            throw MockError.unimplemented
        }
    }
}
