//
//  ChildContextObjectContainer.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


class ChildContextObjectContainer: ObservableObject, Identifiable {
    
    init(_ parentContext: NSManagedObjectContext, _ entityType: EntityType) {

        print("ChildContextObjectContainer parentContext: \(parentContext)")
        self.childContext = NSManagedObjectContext(parentContext)
        print("ChildContextObjectContainer self.childContext: \(self.childContext)")
        
        self.modifier = CoreDataModifier(childContext)
        
        self.object = modifier.createEntity(entityType)
        
    }
    
    init(_ childContext: NSManagedObjectContext, _ entityType: EntityType, _ fix: Bool? = nil) {
        
        self.childContext = childContext
        
        self.modifier = CoreDataModifier(childContext)
        
        self.object = modifier.createEntity(entityType)
        
        print("ChildContextObjectContainer childContext: \(childContext)")
    }
    
    
    let childContext: NSManagedObjectContext
    let modifier: CoreDataModifier
    var object: NSManagedObject
    
    
}




