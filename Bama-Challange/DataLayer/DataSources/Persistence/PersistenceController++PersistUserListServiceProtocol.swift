//
//  PersistenceController++PersistUserListServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import Foundation
import Dependencies

extension PersistenceController: PersistUserListServiceProtocol {

    public func persist<U>(users: U) async throws where U: Sequence, U.Element == UserEntity {
        try await viewContext.perform(schedule: .enqueued) {
            let _ = try users
                .map { user in
                    let userObject = try UserEntityDAO()
                        .translate(user, context: self.viewContext)
                    let addressObject = try fetchAddress(user.address)
                    let companyObject = try fetchCompany(user.company)
                    userObject.address = addressObject
                    userObject.company = companyObject
                    addressObject.addToUser(userObject)
                    companyObject.addToUser(userObject)
                    return userObject
                }
            try self.viewContext.save()
        }
    }

    private func fetchAddress(_ address: AddressEntity) throws -> CDAddressEntity {
        let request = CDAddressEntity.fetchRequest()
        let predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                NSPredicate(format: "street == %@", address.street),
                NSPredicate(format: "suite == %@", address.suite),
                NSPredicate(format: "city == %@", address.city),
                NSPredicate(format: "zipcode == %@", address.zipcode)
            ]
        )
        request.predicate = predicate
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        guard
            let geo = try viewContext.fetch(request).first
        else { throw PersistenceError.requestedItemNotFound }
        return geo
    }
    
    private func fetchCompany(_ company: CompanyEntity) throws -> CDCompanyEntity {
        let request = CDCompanyEntity.fetchRequest()
        let predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                NSPredicate(format: "bs == %@", company.bs),
                NSPredicate(format: "name == %@", company.name),
                NSPredicate(format: "catchPhrase == %@", company.catchPhrase)
            ]
        )
        request.predicate = predicate
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        guard
            let company = try viewContext.fetch(request).first
        else { throw PersistenceError.requestedItemNotFound }
        return company
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var persistUserListDBService: PersistUserListServiceProtocol {
        get { self[PersistUserListServiceProtocolKey.self] }
        set { self[PersistUserListServiceProtocolKey.self] = newValue }
    }

    private enum PersistUserListServiceProtocolKey: DependencyKey {
        static let liveValue: PersistUserListServiceProtocol = PersistenceController.shared
        static var testValue: PersistUserListServiceProtocol  = PersistenceController.shared
    }
}
