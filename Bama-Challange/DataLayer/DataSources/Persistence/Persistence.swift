//
//  Persistence.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import CoreData

internal struct PersistenceController {
    
    internal enum PersistenceError: Error {
        case requestedItemNotFound
    }

    internal static let shared = PersistenceController()
    internal let container: NSPersistentContainer
    internal var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Bama_Challange")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
