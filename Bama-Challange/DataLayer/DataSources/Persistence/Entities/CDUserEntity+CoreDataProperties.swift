//
//  CDUserEntity+CoreDataProperties.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//
//

import Foundation
import CoreData


extension CDUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserEntity> {
        return NSFetchRequest<CDUserEntity>(entityName: "CDUserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var address: CDAddressEntity?
    @NSManaged public var company: CDCompanyEntity?

}

extension CDUserEntity : Identifiable {

}
