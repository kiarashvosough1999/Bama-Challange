//
//  FetchPostsUseCaseStub.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import Foundation
import Bama_Challange
import XCTest

internal struct FetchPostsUseCaseStub {

    let postListItems: [PostListItem]!
    let postItem: PostListItem!
    let postListItemsError: Error!
    let postItemError: Error!

    init(
        postListItems: [PostListItem]? = nil,
        postItem: PostListItem? = nil,
        postListItemsError: Error? = nil,
        postItemError: Error? = nil
    ) {
        self.postListItems = postListItems
        self.postItem = postItem
        self.postListItemsError = postListItemsError
        self.postItemError = postItemError
    }
}

extension FetchPostsUseCaseStub: FetchPostsUseCaseProtocol {

    func fetch() async throws -> [PostListItem] {
        if let postListItems {
            return postListItems
        } else if let postListItemsError {
            throw postListItemsError
        } else {
            return []
        }
    }

    func fetch(with id: Int32) async throws -> PostListItem {
        if let postItem {
            return postItem
        } else if let postItemError {
            throw postItemError
        } else {
            XCTFail("No return value provided")
            fatalError()
        }
    }
}
