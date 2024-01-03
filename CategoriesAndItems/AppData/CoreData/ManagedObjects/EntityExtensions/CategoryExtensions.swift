//
//  CategoryExtensions.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


extension Category {
    
    public var unwrappedID: UUID {
        id ?? UUID()
    }

    // public var unwrappedName: String {
    //     name ?? "name found nil"
    // }
    

    // public var unwrappedDate: Date {
    //     date ?? .now
    // }

    public var unwrapped<#property#>: <#Type#> {
        <#property#> ?? <#example#>
    }
    
    // public var <#attribute#>Array: [<#Entity#>] {
    //      <#attribute#>.unwrap(<#Entity#>.self)
    // }
        
    
}


// MARK: - ObjectStore FetchRequest

extension Category {
    
    public class func objectStoreFetchRequest() -> NSFetchRequest<Category> {
        let request = NSFetchRequest<Category>(entityName: "Category")
            request.sortDescriptors = [NSSortDescriptor(key: "<#property#>", ascending: true)]
        
        return request
    }
    
    
    
    
    
}



// MARK: - Coding Keys

private enum CodingKeys : String, CodingKey {
    case id, name, <#property#>, items
}


// MARK: - Encodable

public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)

    // try container.encode(<#property#>, forKey: .<#property#>)
    
    // try container.encode(itemsArray.map({$0.id}), forKey: .items)
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

    // <#property#> = try container.decode(<#Type#>.self, forKey: .<#property#>)
    
    // let itemsArray = try container.decode([Item].self, forKey: .items)
    // self.items = Set(itemsArray) as NSSet
    
    
    
}


extension Category: Codable { }





// MARK: - RelationalEntity Conformance

extension Category: RelationalEntity {
    
    typealias EntityRelationships = Relationships
 
    enum Relationships: String, CaseIterable {
        case items
    }
    
    func returnRelationship(_ relationship: Relationships) -> ObjectOrNSSet {
        switch relationship {
        // case .items:
        //     return ObjectOrNSSet(object: items)
        }
    }
    
    func returnRelationshipEntityType(_ relationship: Relationships) -> EntityType {
        switch relationship {
        // case .items:
        //     return .items
        }
    }
    
    func inverseRelationshipName(_ relationship: Relationships) -> String {
        switch relationship {
        // case .items:
        //     return "category"
        }
    }
    
}


// MARK: - ObjectPlaceholderCompatible Conformance

extension Category: ObjectPlaceholderCompatible {
    
    var placeholderObjectName: String { unwrapped<#property#> }
    
    var placeholderEntityType: EntityType { .<#entityType#> }
    
}

// MARK: - RelationalPlaceholderObject Conformance

extension Category: RelationalPlaceholderObject {
    
}