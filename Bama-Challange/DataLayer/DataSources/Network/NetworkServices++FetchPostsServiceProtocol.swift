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
            for: Request()
        )
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }

        let response = try result.decode(to: [PostListItem].self)

        return response
    }
}

// MARK: - Request

fileprivate struct Request {}

extension Request: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "posts" }
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
