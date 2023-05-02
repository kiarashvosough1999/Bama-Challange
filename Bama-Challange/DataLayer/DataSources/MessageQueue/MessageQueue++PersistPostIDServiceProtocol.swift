//
//  MessageQueue++PersistPostIDServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import Dependencies

extension MessageQueue: PersistPostIDServiceProtocol {

    private var key: String {
        "Post-ID"
    }
    
    public func persistPost(id: Int32) {
        self.messages[key] = id
    }

    public func retreivePostId() -> Int32? {
        self.messages[key] as? Int32
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var persistPostIdMessageQueueService: PersistPostIDServiceProtocol {
        get { self[PersistPostIDServiceProtocolKey.self] }
        set { self[PersistPostIDServiceProtocolKey.self] = newValue }
    }

    private enum PersistPostIDServiceProtocolKey: DependencyKey {
        static let liveValue: PersistPostIDServiceProtocol = MessageQueue.shared
        static var testValue: PersistPostIDServiceProtocol = MessageQueue.shared
    }
}
