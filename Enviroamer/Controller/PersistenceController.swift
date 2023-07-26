//
//  PersistenceController.swift
//  Enviroamer
//
//  Created by M Yogi Satriawan on 23/07/23.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "TravelPlannerModel")
        let url = URL.StoreURL(for: "group.enviwidget", databaseName: "TravelPlannerModel")
        let storeDescription = NSPersistentStoreDescription(url: url)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

public extension URL {
    static func StoreURL(for appGroup: String, databaseName:String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else{
            fatalError("unable to create URL for \(appGroup)")
        }
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
    
}
