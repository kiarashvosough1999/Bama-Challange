//
//  CDAddressEntity+CoreDataProperties.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//
//

import Foundation
import CoreData


extension CDAddressEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAddressEntity> {
        return NSFetchRequest<CDAddressEntity>(entityName: "CDAddressEntity")
    }

    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var geo: CDGeoEntity?
    @NSManaged public var user: NSSet?

}

// MARK: Generated accessors for user
extension CDAddressEntity {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CDUserEntity)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CDUserEntity)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CDAddressEntity : Identifiable {

}
