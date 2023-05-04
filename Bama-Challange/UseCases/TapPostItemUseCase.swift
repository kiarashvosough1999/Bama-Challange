//
//  TapPostItemUseCase.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Dependencies

// MARK: - Abstraction

public protocol TapPostItemUseCaseProtocol {
    func postTapped(with id: Int32)
}

// MARK: - Implementation

public struct TapPostItemUseCase {
    @Dependency(\.navigationService) private var navigationService
    @Dependency(\.persistPostIdMessageQueueService) private var persistPostIdMessageBrokerService
}

extension TapPostItemUseCase: TapPostItemUseCaseProtocol {

    public func postTapped(with id: Int32) {
        // save id
        persistPostIdMessageBrokerService.persistPost(id: id)
        // request to navigate
        navigationService.push(with: "PostDetailPage")
    }
}

// MARK: - Dependency Registeration

extension DependencyValues {
    
    public var tapPostItemUseCase: TapPostItemUseCaseProtocol {
        get { self[TapPostItemUseCaseKey.self] }
        set { self[TapPostItemUseCaseKey.self] = newValue }
    }
    
    private enum TapPostItemUseCaseKey: DependencyKey {
        static let testValue: TapPostItemUseCaseProtocol = TapPostItemUseCase()
        static let liveValue: TapPostItemUseCaseProtocol = TapPostItemUseCase()
    }
}
