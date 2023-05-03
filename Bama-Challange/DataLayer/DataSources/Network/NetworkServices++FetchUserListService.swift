//
//  NetworkServices++FetchUserListService.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/2/23.
//

import Foundation
import Dependencies

extension NetworkServices: FetchUserListServiceProtocol {

    public func fetchUserList() async throws -> [UserEntity] {
        let result = try await session.data(
            for: PostsRequest()
        )
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }

        let response = try result.decode(to: [UserEntity].self)
        return response
    }
}

// MARK: - PostsRequest

fileprivate struct PostsRequest {}

extension PostsRequest: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "users" }
}

// MARK: - Dependency

extension DependencyValues {

    public var fetchUserListRemoteService: FetchUserListServiceProtocol {
        get { self[FetchUserListServiceProtocolKey.self] }
        set { self[FetchUserListServiceProtocolKey.self] = newValue }
    }

    private enum FetchUserListServiceProtocolKey: DependencyKey {
        static let liveValue: FetchUserListServiceProtocol = NetworkServices.shared
        static var testValue: FetchUserListServiceProtocol  = NetworkServices.shared
    }
}
