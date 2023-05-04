//
//  NavigationServiceStub.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import Foundation
import Bama_Challange
import SwiftUI

internal struct NavigationServiceStub: Mock {

    enum Action: Equatable {
        case push(String)
        case popCount(Int)
        case popTo(String)
    }

    let actions: MockActions<Action>

    init(actions: MockActions<Action>) {
        self.actions = actions
    }
}

extension NavigationServiceStub: NavigationServiceProtocol {

    var pathBinding: Binding<NavigationPath> {
        Binding {
            NavigationPath()
        } set: { _ in }
    }
    
    func push(with value: String) {
        actions.register(.push(value))
    }
    
    func pop(_ count: Int) {
        actions.register(.popCount(count))
    }
    
    func pop(to value: String) {
        actions.register(.popTo(value))
    }
}
