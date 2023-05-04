//
//  TapPostItemUseCaseTests.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import XCTest
import Bama_Challange
import Dependencies

final class TapPostItemUseCaseTests: XCTestCase {
    
    private var sut: TapPostItemUseCase!

    override func setUp() async throws {
        sut = TapPostItemUseCase()
    }

    override func tearDown() async throws {
        sut = nil
    }

    // MARK: - Tests

    func test_post_tapped() async throws {
        let id: Int32 = 1
        let destination = "PostDetailPage"

        let navigationActions = MockActions<NavigationServiceStub.Action>(expected: [.push(destination)])
        let messageQueueActions = MockActions<PersistPostIDServiceStub.Action>(expected: [.persistPost(id)])
        
        withDependencies { values in
            values.navigationService = NavigationServiceStub(actions: navigationActions)
            values.persistPostIdMessageQueueService = PersistPostIDServiceStub(actions: messageQueueActions)
        } operation: {
            sut.postTapped(with: id)
        }

        navigationActions.verify()
        messageQueueActions.verify()
    }
}
