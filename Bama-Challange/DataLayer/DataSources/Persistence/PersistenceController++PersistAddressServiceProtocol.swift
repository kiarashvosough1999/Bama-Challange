//
//  PersistenceController++PersistAddressServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import Foundation
import Dependencies

extension PersistenceController: PersistAddressServiceProtocol {

    public func persist<A>(addresses: A) async throws where A: Sequence, A.Element == AddressEntity {
        try await viewContext.perform(schedule: .enqueued) {
            let _ = try addresses
                .map { address in
                    let addressObject = try AddressEntityDAO()
                        .translate(address, context: self.viewContext)
                    let geoObject = try fetchGeo(address.geo)
                    addressObject.geo = geoObject
                    geoObject.addToAddress(addressObject)
                    return addressObject
                }
            try self.viewContext.save()
        }
    }

    private func fetchGeo(_ geo: GeoEntity) throws -> CDGeoEntity {
        let request = CDGeoEntity.fetchRequest()
        let predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                NSPredicate(format: "lat == %@", geo.lat),
                NSPredicate(format: "lng == %@", geo.lng)
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
}

// MARK: - Dependency

extension DependencyValues {

    public var persistAddressDBService: PersistAddressServiceProtocol {
        get { self[PersistAddressServiceProtocolKey.self] }
        set { self[PersistAddressServiceProtocolKey.self] = newValue }
    }

    private enum PersistAddressServiceProtocolKey: DependencyKey {
        static let liveValue: PersistAddressServiceProtocol = PersistenceController.shared
        static var testValue: PersistAddressServiceProtocol  = PersistenceController.shared
    }
}
