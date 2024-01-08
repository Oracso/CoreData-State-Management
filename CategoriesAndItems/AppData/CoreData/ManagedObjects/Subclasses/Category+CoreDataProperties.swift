//
//  Category+CoreDataProperties.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var details: String?
    @NSManaged public var value: Int64
    @NSManaged public var items: NSSet?
    @NSManaged public var mainItem: Item?
    @NSManaged public var itemTags: NSSet?

}

// MARK: Generated accessors for items
extension Category {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

// MARK: Generated accessors for itemTags
extension Category {

    @objc(addItemTagsObject:)
    @NSManaged public func addToItemTags(_ value: Item)

    @objc(removeItemTagsObject:)
    @NSManaged public func removeFromItemTags(_ value: Item)

    @objc(addItemTags:)
    @NSManaged public func addToItemTags(_ values: NSSet)

    @objc(removeItemTags:)
    @NSManaged public func removeFromItemTags(_ values: NSSet)

}


