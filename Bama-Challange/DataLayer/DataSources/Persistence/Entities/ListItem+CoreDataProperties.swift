//
//  ListItem+CoreDataProperties.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//
//

import Foundation
import CoreData


extension ListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItem> {
        return NSFetchRequest<ListItem>(entityName: "ListItem")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var userId: Int32

}

extension ListItem : Identifiable {

}
