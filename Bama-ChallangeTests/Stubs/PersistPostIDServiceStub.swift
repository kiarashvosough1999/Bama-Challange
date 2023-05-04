//
//  PersistPostIDServiceStub.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import Foundation
import Bama_Challange

internal struct PersistPostIDServiceStub: Mock {

    enum Action: Equatable {
        case persistPost(Int32)
    }
    
    let actions: MockActions<Action>
    private let postId: Int32?

    init(actions: MockActions<Action>, postId: Int32? = nil) {
        self.actions = actions
        self.postId = postId
    }
}

extension PersistPostIDServiceStub: PersistPostIDServiceProtocol {

    func persistPost(id: Int32){
        actions.register(.persistPost(id))
    }

    func retreivePostId() -> Int32? {
        postId
    }
}
