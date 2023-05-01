//
//  PersistenceController++FetchPostsServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Dependencies
import CoreData

extension PersistenceController: FetchPostsServiceProtocol {

    func fetchPosts() async throws -> [PostListItem] {
        try await self.viewContext.perform(schedule: .immediate) {
            let request = ListItem.fetchRequest()
            request.returnsObjectsAsFaults = false
            let result = try self.viewContext.fetch(request)
            return result
        }.map {
            try PostListItemDAO().translate($0, context: nil)
        }
    }
}

// MARK: - Dependency

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
