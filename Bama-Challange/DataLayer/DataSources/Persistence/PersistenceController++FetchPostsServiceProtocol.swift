//
//  PersistenceController++FetchPostsServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Dependencies
import CoreData

extension PersistenceController: FetchPostsServiceProtocol {

    public func fetchPosts() async throws -> [PostListItem] {
        try await self.viewContext.perform(schedule: .immediate) {
            let request = ListItem.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(key: "id", ascending: true)
            ]
            request.returnsObjectsAsFaults = false
            let result = try self.viewContext.fetch(request)
            return result
        }.map {
            try PostListItemDAO().translate($0, context: nil)
        }
    }

    public func fetchPost(with id: Int32) async throws -> PostListItem {
        let fetchedItem: PostListItem? = try await self.viewContext.perform(schedule: .immediate) {
            let predicate = NSPredicate(format: "id == %i", id)
            let request = ListItem.fetchRequest()

            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            request.fetchLimit = 1
            let result = try self.viewContext.fetch(request)
            return result
        }.map {
            try PostListItemDAO().translate($0, context: nil)
        }.first
        guard let fetchedItem else { throw PersistenceError.requestedItemNotFound }
        return fetchedItem
    }
}

// MARK: - Dependency Registeration

extension DependencyValues {

    public var fetchPostsDBService: FetchPostsServiceProtocol {
        get { self[FetchPostsServiceProtocolKey.self] }
        set { self[FetchPostsServiceProtocolKey.self] = newValue }
    }

    private enum FetchPostsServiceProtocolKey: DependencyKey {
        static let liveValue: FetchPostsServiceProtocol = PersistenceController.shared
        static var testValue: FetchPostsServiceProtocol  = PersistenceController.shared
    }
}
