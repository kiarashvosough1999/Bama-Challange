//
//  PersistenceController++PersistCompanyServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import Foundation
import Dependencies

extension PersistenceController: PersistCompanyServiceProtocol {

    public func persist<C>(companies: C) async throws where C: Sequence, C.Element == CompanyEntity {
        try await viewContext.perform(schedule: .enqueued) {
            let _ = try companies
                .filter { company in
                    try isCompanyExist(company) == false
                }
                .map { geo in
                    try CompanyEntityDAO().translate(geo, context: self.viewContext)
                }
            try self.viewContext.save()
        }
    }

    private func isCompanyExist(_ company: CompanyEntity) throws -> Bool {
        let request = CDCompanyEntity.fetchRequest()
        let predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                NSPredicate(format: "bs == %@", company.bs),
                NSPredicate(format: "name == %@", company.name),
                NSPredicate(format: "catchPhrase == %@", company.catchPhrase)
            ]
        )
        request.predicate = predicate
        let count = try viewContext.count(for: request)
        return count == 0 ? false : true
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var persistCompanyDBService: PersistCompanyServiceProtocol {
        get { self[PersistCompanyServiceProtocolKey.self] }
        set { self[PersistCompanyServiceProtocolKey.self] = newValue }
    }

    private enum PersistCompanyServiceProtocolKey: DependencyKey {
        static let liveValue: PersistCompanyServiceProtocol = PersistenceController.shared
        static var testValue: PersistCompanyServiceProtocol  = PersistenceController.shared
    }
}
