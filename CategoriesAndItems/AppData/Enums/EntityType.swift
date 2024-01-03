//
//  EntityType.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


enum EntityType: String, Identifiable, CaseIterable, Codable {
    case category = "Category"
    case item = "Item"
    var id: Self { self }
}


extension EntityType {
    var withSpaces: String {
        self.rawValue.insertSpacesBeforeUppercaseLetters()
    }
}


extension EntityType {
    func entityClass() -> NSManagedObject.Type {
        switch self {
        case .category:
            return Category.self
        case .item:
            return Item.self
        }
    }

    init<T: NSManagedObject>(classType: T.Type) {
        switch classType {
        case is Category.Type:
            self = .category
        case is Item.Type:
            self = .item
        default:
            fatalError("Unsupported NSManagedObject Type")
        }
    }
}

extension EntityType {
    func pluralRawValue() -> String {
        switch self {
        case .category:
            return "Categories"
        case .item:
            return "Items"
        }
    }
}




// MARK: - EntityType initialisers from NSManagedObject

extension NSManagedObject {
    func entityType() -> EntityType? {
        EntityType(rawValue: entity.name ?? "entity description fail")
    }
}

extension NSManagedObject {
    func entityTypeRawValue() -> String {
        EntityType(rawValue: entity.name ?? "entity description fail")?.rawValue ?? "EntityType not found"
    }
}

// MARK: - EntityType initialisers from [NSManagedObject]

extension Array where Array == [NSManagedObject] {
    func arrayEntityType() -> EntityType? {
        if let first = self.first {
            return first.entityType()
        } else {
            return nil
        }
    }
}




