//
//  NSPersistentContainerSubClass.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


class NSPersistentContainerSubClass: NSPersistentContainer {
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
            let context = backgroundContext ?? viewContext
            guard context.hasChanges else { return }
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error), \(error.userInfo)")
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                // The fatalError() causes the app to crash, may be useful during development but DO NOT SHIP
            }
        // where to include "print("No changes to context found - context NOT saved")" ???
        }
    
    // "The above example adds a saveContext function to the container, to improve performance by saving the context only when there are changes." - Apple Documentation
    
    
    func saveToParent(_ object: NSManagedObject) {
        try! object.managedObjectContext?.save()    // saves child context to view context
        if let parent = object.managedObjectContext?.parent {
            try! parent.save()      // saves view context to persistent store
        }
    }
    
    
}





extension NSManagedObjectContext {
    
    func saveIfChanges() {
            guard self.hasChanges else { return }
            do {
                try self.save()
            } catch let error as NSError {
                print("Error: \(error), \(error.userInfo)")
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                // The fatalError() causes the app to crash, may be useful during development but DO NOT SHIP
            }
        }
}


// MARK: - Background Context

extension NSPersistentContainerSubClass {
    
    func createBackgroundContext() -> NSManagedObjectContext {
        let backgroundContext = newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
        return backgroundContext
    }
    
}



extension NSManagedObjectContext {

    enum ReturnObjectIDFromStringError: Error {
        case urlNil
        case objectIDNil
    }
    
    
    func returnObjectIDFromURL(_ url: URL) -> NSManagedObjectID? {
        
        let id = persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url)
        
       return id
    }
    
  
    
    
    
}


extension NSPersistentContainerSubClass {
    func returnObjectIDFromURLL(_ url: URL) -> NSManagedObjectID? {
        
        let objectID = persistentStoreCoordinator.managedObjectID(forURIRepresentation: url)
        
        return objectID
        
       
        
    }
}

