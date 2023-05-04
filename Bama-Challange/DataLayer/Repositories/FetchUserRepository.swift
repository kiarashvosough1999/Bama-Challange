//
//  FetchUserRepository.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import Dependencies
import Foundation

// MARK: - Abstraction

public protocol FetchUsersRepositoryProtocol {
    func fetchUsers() async throws -> [UserEntity]
}

// MARK: - Implementation

public struct FetchUsersRepository {
    @Dependency(\.fetchUserListDBService) private var fetchUserListDBService
    @Dependency(\.fetchUserListRemoteService) private var fetchUserListRemoteService
    @Dependency(\.persistGeoDBService) private var persistGeoDBService
    @Dependency(\.persistCompanyDBService) private var persistCompanyDBService
    @Dependency(\.persistAddressDBService) private var persistAddressDBService
    @Dependency(\.persistUserListDBService) private var persistUserListDBService
}

extension FetchUsersRepository: FetchUsersRepositoryProtocol {

    public func fetchUsers() async throws -> [UserEntity] {
        if let results = try? await fetchUserListDBService.fetchUserList(), results.isEmpty == false {
            return results
        } else if let users = try? await fetchUserListRemoteService.fetchUserList(), users.isEmpty == false {
            Task {
                do {
                    try await persistGeoDBService.persist(geos: Set(users.map(\.address.geo)))
                    try await persistCompanyDBService.persist(companies: Set(users.map(\.company)))
                    try await persistAddressDBService.persist(addresses: Set(users.map(\.address)))
                    try await persistUserListDBService.persist(users: users)
                } catch {
                    print(error)
                }
            }
            return users
        } else {
            return []
        }
    }
}

// MARK: - Dependency

extension DependencyValues {
    
    public var fetchUsersRepository: FetchUsersRepositoryProtocol {
        get { self[FetchUserRepositoryProtocolKey.self] }
        set { self[FetchUserRepositoryProtocolKey.self] = newValue }
    }
    
    private enum FetchUserRepositoryProtocolKey: DependencyKey {
        static let liveValue: FetchUsersRepositoryProtocol = FetchUsersRepository()
        static let previewValue: FetchUsersRepositoryProtocol = FetchUsersRepository()
    }
}
