//
//  Category+CoreDataClass.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

    
    
    // MARK: - Coding Keys
    
    private enum CodingKeys : String, CodingKey {
        case id, name, date, details, value, items, itemTags, mainItem
    }
    
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(details, forKey: .details)
        try container.encode(value, forKey: .value)
        
        try container.encode(items.unwrap(Item.self).map({$0.id}), forKey: .name)
        try container.encode(itemTags.unwrap(Item.self).map({$0.id}), forKey: .name)
        try container.encode(mainItem, forKey: .mainItem)
        
        
    }
    
    
    // MARK: - Decodable
    
    
    public required convenience init(from decoder: Decoder) throws {
        
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext) else {  fatalError("Failed to decode Category!")  }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        details = try container.decode(String.self, forKey: .details)
        value = try container.decode(Int64.self, forKey: .value)
        
        let decodedItems = try container.decode([Item].self, forKey: .items)
        items = Set(decodedItems) as NSSet
        
        let decodedItemTags = try container.decode([Item].self, forKey: .itemTags)
        itemTags = Set(decodedItemTags) as NSSet
        
        mainItem = try container.decode(Item.self, forKey: .mainItem)
        
    }
    
    
}


extension Category: Codable { }
