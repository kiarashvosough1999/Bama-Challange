//
//  NetworkServices++FetchPostsRepository.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Dependencies
import Foundation

extension NetworkServices: FetchPostsServiceProtocol {

    public func fetchPosts() async throws -> [PostListItem] {
        let result = try await session.data(
            for: PostsRequest()
        )
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }

        let response = try result.decode(to: [PostListItem].self)

        return response
    }

    public func fetchPost(with id: Int32) async throws -> PostListItem {
        let result = try await session.data(
            for: PostRequest(id: id)
        )
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }

        let response = try result.decode(to: PostListItem.self)

        return response
    }
}

// MARK: - PostsRequest

fileprivate struct PostsRequest {}

extension PostsRequest: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "posts" }
}

// MARK: - PostRequest

fileprivate struct PostRequest {
    private let id: Int32

    fileprivate init(id: Int32) {
        self.id = id
    }
}

extension PostRequest: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "posts/\(id)" }
}

// MARK: - Dependency

extension DependencyValues {

    public var fetchPostsRemoteService: FetchPostsServiceProtocol {
        get { self[FetchPostsServiceProtocolKey.self] }
        set { self[FetchPostsServiceProtocolKey.self] = newValue }
    }

    private enum FetchPostsServiceProtocolKey: DependencyKey {
        static let liveValue: FetchPostsServiceProtocol = NetworkServices.shared
        static var testValue: FetchPostsServiceProtocol  = NetworkServices.shared
    }
}
