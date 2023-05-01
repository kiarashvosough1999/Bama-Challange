//
//  TapPostItemUseCase.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Dependencies

public protocol TapPostItemUseCaseProtocol {
    func postTapped(with id: Int32)
}

public struct TapPostItemUseCase {
    
}

extension TapPostItemUseCase: TapPostItemUseCaseProtocol {

    public func postTapped(with id: Int32) {
        
    }
}

extension DependencyValues {
    
    public var tapPostItemUseCase: TapPostItemUseCaseProtocol {
        get { self[TapPostItemUseCaseKey.self] }
        set { self[TapPostItemUseCaseKey.self] = newValue }
    }
    
    private enum TapPostItemUseCaseKey: DependencyKey {
        static let liveValue: TapPostItemUseCaseProtocol = TapPostItemUseCase()
    }
}
