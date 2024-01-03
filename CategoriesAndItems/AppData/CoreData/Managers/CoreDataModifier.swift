//
//  CoreDataModifier.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


struct CoreDataModifier {

    let context: NSManagedObjectContext
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    
    
    // MARK: - Create Entity
    
    func createEntity(_ entityType: EntityType) -> NSManagedObject {
        switch entityType {
        case .category:
            return createCategory()
        case .item:
            return createItem()
        }
    }
    
    
    func createCategory() -> Category {
        let example = Category(context: context)
        example.id = UUID()
        return example
    }
    
    
    func createItem() -> Item {
        let example = Item(context: context)
        example.id = UUID()
        return example
    }
    



    // MARK: - Delete Entity
    
    // func deleteObject(object: NSManagedObject) {
    //     context.delete(object)
    // }
    
    
    
}

