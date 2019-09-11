//
//  CoreDataManager.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import Foundation
import CoreData

/// Singleton class to ensure that all CRUD operations go through the same coordinators and context

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    
    // MARK: - Core Data stack
    
    /// container for the object context to store data into.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: coreDataContainerName )
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                debugLog("Pesistent store not loaded \(error.localizedDescription)")
                return
            }
            print("Pesistent store loaded")
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    /// Used by the persistentContainer to save the current context and apply all of its operations (SAVE,DELETE, UPDATE, UNDO etc)
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugLog("Unresolved context error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
