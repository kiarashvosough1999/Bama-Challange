//
//  UserEntityDAO.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import CoreData

internal struct UserEntityDAO: DAO {

    typealias LowLevelModel = CDUserEntity
    typealias HighLevelModel = UserEntity
    typealias Context = NSManagedObjectContext

    func translate(
        _ model: CDUserEntity,
        context: NSManagedObjectContext?
    ) throws -> UserEntity {
        UserEntity(
            id: model.id,
            name: model.name!,
            username: model.username!,
            email: model.email!,
            address: AddressEntity(
                street: model.address!.street!,
                suite: model.address!.suite!,
                city: model.address!.city!,
                zipcode: model.address!.zipcode!,
                geo: GeoEntity(
                    lat: model.address!.geo!.lat!,
                    lng: model.address!.geo!.lng!
                )
            ),
            phone: model.phone!,
            website: model.website!,
            company: CompanyEntity(
                name: model.company!.name!,
                catchPhrase: model.company!.name!,
                bs: model.company!.bs!
            )
        )
    }

    func translate(
        _ model: UserEntity,
        context: NSManagedObjectContext?
    ) throws -> CDUserEntity {
        guard let context else { throw NSError() }
        let userObject = CDUserEntity(context: context)
        userObject.id = model.id
        userObject.name = model.name
        userObject.username = model.username
        userObject.email = model.email
        userObject.phone = model.phone
        userObject.website = model.website
        return userObject
    }
}
