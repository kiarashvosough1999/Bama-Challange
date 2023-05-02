//
//  FetchPostsServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

public protocol FetchPostsServiceProtocol {
    func fetchPosts() async throws -> [PostListItem]
    func fetchPost(with id: Int32) async throws -> PostListItem
}
