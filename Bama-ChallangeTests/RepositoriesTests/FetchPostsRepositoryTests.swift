//
//  FetchPostsRepositoryTests.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import XCTest
import Bama_Challange
import Dependencies

final class FetchPostsRepositoryTests: XCTestCase {

    private var sut: FetchPostsRepositoryProtocol!
    
    override func setUp() async throws {
        sut = FetchPostsRepository()
    }

    override func tearDown() async throws {
        sut = nil
    }

    // fetchPosts

    func test_fetch_posts_success_db() async throws{
        let posts = try loadJSON(name: "posts", as: [PostListItem].self)
        
        let resultPosts = try await withDependencies { values in
            values.fetchPostsRemoteService = FetchPostsServiceStub()
            values.fetchPostsDBService = FetchPostsServiceStub(posts: posts)
            values.persistPostsDBService = PersistPostsServiceStub()
        } operation: {
            try await sut.fetchPosts()
        }

        XCTAssertEqual(posts, resultPosts)
    }

    func test_fetch_posts_db_empty_remote_success() async throws{
        let dbPosts: [PostListItem] = []
        let remotePosts = try loadJSON(name: "posts", as: [PostListItem].self)
        
        let persistActions = MockActions<PersistPostsServiceStub.Action>(expected: [.persistPosts(remotePosts)])

        let resultPosts = try await withDependencies { values in
            values.fetchPostsRemoteService = FetchPostsServiceStub(posts: remotePosts)
            values.fetchPostsDBService = FetchPostsServiceStub(posts: dbPosts)
            values.persistPostsDBService = PersistPostsServiceStub(actions: persistActions)
        } operation: {
            try await sut.fetchPosts()
        }

        persistActions.verify()
        XCTAssertEqual(remotePosts, resultPosts)
    }

    func test_fetch_posts_db_empty_remote_empty() async throws{
        let dbPosts: [PostListItem] = []
        let remotePosts: [PostListItem] = []

        let resultPosts = try await withDependencies { values in
            values.fetchPostsRemoteService = FetchPostsServiceStub(posts: remotePosts)
            values.fetchPostsDBService = FetchPostsServiceStub(posts: dbPosts)
        } operation: {
            try await sut.fetchPosts()
        }

        XCTAssertEqual(resultPosts, [])
    }

    // fetchPost

    func test_fetch_post_success_db() async throws{
        let id: Int32 = 2
        let post = try loadJSON(name: "posts", as: [PostListItem].self).first
        XCTAssertNotNil(post)
        
        let resultPosts = try await withDependencies { values in
            values.fetchPostsRemoteService = FetchPostsServiceStub()
            values.fetchPostsDBService = FetchPostsServiceStub(post: post)
            values.persistPostsDBService = PersistPostsServiceStub()
        } operation: {
            try await sut.fetchPost(with: id)
        }

        XCTAssertEqual(post, resultPosts)
    }

    func test_fetch_post_db_empty_remote_success() async throws{
        let id: Int32 = 2
        let dbPost: PostListItem? = nil
        let remotePost = try loadJSON(name: "posts", as: [PostListItem].self).first
        XCTAssertNotNil(remotePost)

        let resultPost = try await withDependencies { values in
            values.fetchPostsRemoteService = FetchPostsServiceStub(post: remotePost)
            values.fetchPostsDBService = FetchPostsServiceStub(post: dbPost)
        } operation: {
            try await sut.fetchPost(with: id)
        }

        XCTAssertEqual(remotePost, resultPost)
    }

    func test_fetch_post_db_empty_remote_empty() async throws {
        let id: Int32 = 2
        let dbPost: PostListItem? = nil
        let remotePost: PostListItem? = nil

        let _ = try await withDependencies { values in
            values.fetchPostsRemoteService = FetchPostsServiceStub(post: remotePost)
            values.fetchPostsDBService = FetchPostsServiceStub(post: dbPost)
        } operation: {
            await XCTAssertThrowsError(try await sut.fetchPost(with: id))
        }
    }
}
