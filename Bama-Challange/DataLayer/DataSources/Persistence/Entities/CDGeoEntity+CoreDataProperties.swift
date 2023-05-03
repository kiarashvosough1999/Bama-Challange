//
//  CDGeoEntity+CoreDataProperties.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//
//

import Foundation
import CoreData


extension CDGeoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeoEntity> {
        return NSFetchRequest<CDGeoEntity>(entityName: "CDGeoEntity")
    }

    @NSManaged public var lat: String?
    @NSManaged public var lng: String?
    @NSManaged public var address: NSSet?

}

// MARK: Generated accessors for address
extension CDGeoEntity {

    @objc(addAddressObject:)
    @NSManaged public func addToAddress(_ value: CDAddressEntity)

    @objc(removeAddressObject:)
    @NSManaged public func removeFromAddress(_ value: CDAddressEntity)

    @objc(addAddress:)
    @NSManaged public func addToAddress(_ values: NSSet)

    @objc(removeAddress:)
    @NSManaged public func removeFromAddress(_ values: NSSet)

}

extension CDGeoEntity : Identifiable {

}
