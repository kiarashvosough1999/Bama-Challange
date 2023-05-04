//
//  PersistPostsServiceStub.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import Foundation
import Bama_Challange
import XCTest

struct PersistPostsServiceStub: Mock {

    enum Action: Equatable {
        case persistPosts([PostListItem])
    }

    let actions: MockActions<Action>

    init(actions: MockActions<Action> = .init(expected: [])) {
        self.actions = actions
    }
}


extension PersistPostsServiceStub: PersistPostsServiceProtocol {
    func persistPosts(items: [PostListItem]) async throws {
        actions.register(.persistPosts(items))
    }
}
