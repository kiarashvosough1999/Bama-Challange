//
//  PersistenceController++PersistGeoServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import Foundation
import Dependencies

extension PersistenceController: PersistGeoServiceProtocol {

    public func persist<G>(geos: G) async throws where G: Sequence, G.Element == GeoEntity {
        try await viewContext.perform(schedule: .enqueued) {
            let _ = try geos
                .filter { geo in
                    try isGeoExist(geo) == false
                }
                .map { geo in
                    try GeoEntityDAO().translate(geo, context: self.viewContext)
                }
            try self.viewContext.save()
        }
    }

    private func isGeoExist(_ geo: GeoEntity) throws -> Bool {
        let request = CDGeoEntity.fetchRequest()
        let predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                NSPredicate(format: "lat == %@", geo.lat),
                NSPredicate(format: "lng == %@", geo.lng)
            ]
        )
        request.predicate = predicate
        let count = try viewContext.count(for: request)
        return count == 0 ? false : true
    }
}


// MARK: - Dependency

extension DependencyValues {

    public var persistGeoDBService: PersistGeoServiceProtocol {
        get { self[PersistGeoServiceProtocolKey.self] }
        set { self[PersistGeoServiceProtocolKey.self] = newValue }
    }

    private enum PersistGeoServiceProtocolKey: DependencyKey {
        static let liveValue: PersistGeoServiceProtocol = PersistenceController.shared
        static var testValue: PersistGeoServiceProtocol  = PersistenceController.shared
    }
}
