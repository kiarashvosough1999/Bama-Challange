//
//  PersistenceController++FetchUserListServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import Foundation
import Dependencies

extension PersistenceController: FetchUserListServiceProtocol {

    public func fetchUserList() async throws -> [UserEntity] {
        try await self.viewContext.perform(schedule: .immediate) {
            let request = CDUserEntity.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(key: "id", ascending: true)
            ]
            request.returnsObjectsAsFaults = false
            let result = try self.viewContext.fetch(request)
            return result
        }.map {
            try UserEntityDAO().translate($0, context: nil)
        }
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var fetchUserListDBService: FetchUserListServiceProtocol {
        get { self[FetchUserListServiceProtocolKey.self] }
        set { self[FetchUserListServiceProtocolKey.self] = newValue }
    }

    private enum FetchUserListServiceProtocolKey: DependencyKey {
        static let liveValue: FetchUserListServiceProtocol = PersistenceController.shared
        static var testValue: FetchUserListServiceProtocol  = PersistenceController.shared
    }
}
