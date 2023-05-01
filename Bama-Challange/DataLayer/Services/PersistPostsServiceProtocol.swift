//
//  PersistPostsServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

public protocol PersistPostsServiceProtocol {
    func persistPosts(items: [PostListItem]) async throws
}
