//
//  TapPostItemUseCaseStub.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import Bama_Challange

internal struct TapPostItemUseCaseStub: Mock {

    internal enum Action: Equatable {
        case postTapped(id: Int32)
    }

    internal let actions: MockActions<Action>

    internal init(actions: MockActions<Action>) {
        self.actions = actions
    }
}

extension TapPostItemUseCaseStub: TapPostItemUseCaseProtocol {

    func postTapped(with id: Int32) {
        actions.register(.postTapped(id: id))
    }
}
