//
//  Item+CoreDataClass.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    
    
    // MARK: - Coding Keys
    
    private enum CodingKeys : String, CodingKey {
        case id, name, date, details, value, category, categoryTags, mainCategory
    }
    
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(details, forKey: .details)
        try container.encode(value, forKey: .value)
        
        try container.encode(category, forKey: .category)
        try container.encode(categoryTags.unwrap(Category.self).map({$0.id}), forKey: .categoryTags)
        try container.encode(mainCategory, forKey: .mainCategory)
        
    }
    
    
    // MARK: - Decodable
    
    
    public required convenience init(from decoder: Decoder) throws {
        
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedObjectContext) else {  fatalError("Failed to decode Item!")  }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
         date = try container.decode(Date.self, forKey: .date)
         details = try container.decode(String.self, forKey: .details)
        value = try container.decode(Int64.self, forKey: .value)
        
        category = try container.decode(Category.self, forKey: .category)
        
        let decodedCategoryTags = try container.decode([Category].self, forKey: .categoryTags)
        categoryTags = Set(decodedCategoryTags) as NSSet
        
        mainCategory = try container.decode(Category.self, forKey: .mainCategory)
        
        
        
        
        
        
    }
    
    
    
}


extension Item: Codable { }

