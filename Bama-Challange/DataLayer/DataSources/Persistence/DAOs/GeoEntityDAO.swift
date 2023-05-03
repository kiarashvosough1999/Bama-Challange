//
//  GeoEntityDAO.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import CoreData

struct GeoEntityDAO: DAO {

    typealias LowLevelModel = CDGeoEntity
    typealias HighLevelModel = GeoEntity
    typealias Context = NSManagedObjectContext

    func translate(_ model: CDGeoEntity, context: NSManagedObjectContext?) throws -> GeoEntity {
        GeoEntity(
            lat: model.lat!,
            lng: model.lng!
        )
    }

    func translate(_ model: GeoEntity, context: NSManagedObjectContext?) throws -> CDGeoEntity {
        guard let context else { throw NSError() }
        let geoObject = CDGeoEntity(context: context)
        geoObject.lat = model.lat
        geoObject.lng = model.lng
        return geoObject
    }
}
