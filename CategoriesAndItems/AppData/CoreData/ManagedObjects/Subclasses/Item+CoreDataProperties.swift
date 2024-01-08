//
//  Item+CoreDataProperties.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var details: String?
    @NSManaged public var value: Int64
    @NSManaged public var category: Category?
    @NSManaged public var mainCategory: Category?
    @NSManaged public var categoryTags: NSSet?

}

// MARK: Generated accessors for categoryTags
extension Item {

    @objc(addCategoryTagsObject:)
    @NSManaged public func addToCategoryTags(_ value: Category)

    @objc(removeCategoryTagsObject:)
    @NSManaged public func removeFromCategoryTags(_ value: Category)

    @objc(addCategoryTags:)
    @NSManaged public func addToCategoryTags(_ values: NSSet)

    @objc(removeCategoryTags:)
    @NSManaged public func removeFromCategoryTags(_ values: NSSet)

}


