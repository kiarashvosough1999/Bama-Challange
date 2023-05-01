//
//  FetchPostsRepository.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Dependencies

// MARK: - Abstraction

public protocol FetchPostsRepositoryProtocol {
    func fetchPosts() async throws -> [PostListItem]
}

// MARK: - Implementation

public struct FetchPostsRepository {
    @Dependency(\.fetchPostsRemoteService) private var fetchPostsRemoteService
    @Dependency(\.fetchPostsDBService) private var fetchPostsDBService
    @Dependency(\.persistPostsDBService) private var persistPostsDBService
}

extension FetchPostsRepository: FetchPostsRepositoryProtocol {

    public func fetchPosts() async throws -> [PostListItem] {
        if let results = try? await fetchPostsDBService.fetchPosts(), results.isEmpty == false {
            return results
        } else if let results = try? await fetchPostsRemoteService.fetchPosts(), results.isEmpty == false {
            Task {
                try? await persistPostsDBService.persistPosts(items: results)
            }
            return results
        } else {
            return []
        }
    }
}

extension DependencyValues {
    
    public var fetchPostsRepository: FetchPostsRepositoryProtocol {
        get { self[FetchPostsRepositoryProtocolKey.self] }
        set { self[FetchPostsRepositoryProtocolKey.self] = newValue }
    }
    
    private enum FetchPostsRepositoryProtocolKey: DependencyKey {
        static let liveValue: FetchPostsRepositoryProtocol = FetchPostsRepository()
        static let previewValue: FetchPostsRepositoryProtocol = FetchPostsRepository()
    }
}
