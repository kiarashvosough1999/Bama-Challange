//
//  PersistenceController++PersistPostsServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import CoreData
import Dependencies

extension PersistenceController: PersistPostsServiceProtocol {

    public func persistPosts(items: [PostListItem]) async throws {
        try await viewContext.perform(schedule: .enqueued) {
            let managedObjectModels = try items.map {
                try PostListItemDAO().translate($0, context: self.viewContext)
            }
            try self.viewContext.save()
        }
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var persistPostsDBService: PersistPostsServiceProtocol {
        get { self[PersistPostsServiceProtocolKey.self] }
        set { self[PersistPostsServiceProtocolKey.self] = newValue }
    }

    private enum PersistPostsServiceProtocolKey: DependencyKey {
        static let liveValue: PersistPostsServiceProtocol = PersistenceController.shared
        static var testValue: PersistPostsServiceProtocol  = PersistenceController.shared
    }
}
