//
//  AddressEntityDAO.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import CoreData

struct AddressEntityDAO: DAO {

    typealias LowLevelModel = CDAddressEntity
    typealias HighLevelModel = AddressEntity
    typealias Context = NSManagedObjectContext

    func translate(
        _ model: CDAddressEntity,
        context: NSManagedObjectContext?
    ) throws -> AddressEntity {
        AddressEntity(
            street: model.street!,
            suite: model.suite!,
            city: model.city!,
            zipcode: model.zipcode!,
            geo: GeoEntity(
                lat: model.geo!.lat!,
                lng: model.geo!.lng!
            )
        )
    }
    
    func translate(
        _ model: AddressEntity,
        context: NSManagedObjectContext?
    ) throws -> CDAddressEntity {
        guard let context else { throw NSError() }
        let companyObject = CDAddressEntity(context: context)
        companyObject.street = model.street
        companyObject.suite = model.suite
        companyObject.city = model.city
        companyObject.zipcode = model.zipcode
        return companyObject
    }
}
