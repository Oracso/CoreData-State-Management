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
    
    
    func createCategory(name: String = "", date: Date = .now, details: String? = nil, value: Int64 = 0) -> Category {
        let example = Category(context: context)
        example.id = UUID()
        example.name = name
        example.date = date
        example.details = details
        example.value = value
        return example
    }
    
    
    func createItem(name: String = "", date: Date = .now, details: String? = nil, value: Int64 = 0) -> Item {
        let example = Item(context: context)
        example.id = UUID()
        example.name = name
        example.date = date
        example.details = details
        example.value = value
        return example
    }
    
    
}

