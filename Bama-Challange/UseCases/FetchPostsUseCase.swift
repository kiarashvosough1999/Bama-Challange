//
//  FetchPostsUseCase.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Foundation
import Dependencies

// MARK: - Abstraction

public protocol FetchPostsUseCaseProtocol {
    func fetch() async throws -> [PostListItem]
    func fetch(with id: Int32) async throws -> PostListItem
}

// MARK: - Implementation

public struct FetchPostsUseCase {
    @Dependency(\.fetchPostsRepository) private var fetchPostsRepository
}

extension FetchPostsUseCase: FetchPostsUseCaseProtocol {

    public func fetch() async throws -> [PostListItem] {
        do {
            return try await fetchPostsRepository.fetchPosts()
        } catch {
            
        }
        return []
    }

    public func fetch(with id: Int32) async throws -> PostListItem {
        return try await fetchPostsRepository.fetchPost(with: id)
    }
}

// MARK: - Preview Implementation

#if DEBUG
private struct FetchPostsUseCasePreview: FetchPostsUseCaseProtocol {

    public func fetch(with id: Int32) async throws -> PostListItem {
        PostListItem(
            id: Int32(id),
            title: "test Value",
            body: Array(
                repeating: "smthing",
                count: 20
            ).reduce(into: "") { partialResult, next in
                partialResult += next
            },
            userId: .zero
        )
    }

    public func fetch() -> [PostListItem] {
        stride(from: 0, to: 20, by: 1).map { id in
            let item = PostListItem(
                id: Int32(id),
                title: "test Value",
                body: Array(
                    repeating: "smthing",
                    count: 20
                ).reduce(into: "") { partialResult, next in
                    partialResult += next
                },
                userId: .zero
            )
            return item
        }
    }
}
#endif

// MARK: - Dependency

extension DependencyValues {
    
    public var fetchPostsUseCase: FetchPostsUseCaseProtocol {
        get { self[FetchPostsUseCaseKey.self] }
        set { self[FetchPostsUseCaseKey.self] = newValue }
    }
    
    private enum FetchPostsUseCaseKey: DependencyKey {
        static let liveValue: FetchPostsUseCaseProtocol = FetchPostsUseCase()
        static let previewValue: FetchPostsUseCaseProtocol = FetchPostsUseCasePreview()
    }
}
