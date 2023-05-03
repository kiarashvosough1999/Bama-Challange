//
//  CDCompanyEntity+CoreDataProperties.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//
//

import Foundation
import CoreData


extension CDCompanyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCompanyEntity> {
        return NSFetchRequest<CDCompanyEntity>(entityName: "CDCompanyEntity")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?
    @NSManaged public var user: NSSet?

}

// MARK: Generated accessors for user
extension CDCompanyEntity {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CDUserEntity)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CDUserEntity)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CDCompanyEntity : Identifiable {

}
