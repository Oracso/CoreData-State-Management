//
//  ItemExtensions.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


extension Item {
    
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

extension Item {
    
    public class func objectStoreFetchRequest() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
            request.sortDescriptors = [NSSortDescriptor(key: "<#property#>", ascending: true)]
        
        return request
    }
    
    
    
    
    
}



// MARK: - Coding Keys

private enum CodingKeys : String, CodingKey {
    case id, name, <#property#>, <#attribute#>
}


// MARK: - Encodable

public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)

    // try container.encode(<#property#>, forKey: .<#property#>)
    
    // try container.encode(<#attribute#>Array.map({$0.id}), forKey: .<#attribute#>)
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

    // <#property#> = try container.decode(<#Type#>.self, forKey: .<#property#>)
    
    // let <#attribute#>Array = try container.decode([<#Entity#>].self, forKey: .<#attribute#>)
    // self.<#attribute#> = Set(<#attribute#>Array) as NSSet
    
    
    
}


extension Item: Codable { }





// MARK: - RelationalEntity Conformance

extension Item: RelationalEntity {
    
    typealias EntityRelationships = Relationships
 
    enum Relationships: String, CaseIterable, CardinalRelationships {
        case <#attribute#>

        typealias ToOneRelationships = ToOne
        
        enum ToOne: CaseIterable {
            
        }
        
        typealias ToManyRelationships = ToMany
        
        enum ToMany: CaseIterable {

        }

    }
    
    func returnRelationship(_ relationship: Relationships) -> ObjectOrNSSet {
        switch relationship {
            // return ObjectOrNSSet(object: <#attribute#>)
        }
    }
    
    func returnRelationshipEntityType(_ relationship: Relationships) -> EntityType {
        switch relationship {
            // return .<#attribute#>
        }
    }
    
    func inverseRelationshipName(_ relationship: Relationships) -> String {
        switch relationship {
            // return "<#relationship#>"
        }
    }
    
}

// MARK: - ToManyEntity Conformance

// extension Item: ToManyEntity {
    
//     typealias ToManyEnum = EntityRelationships.ToManyRelationships
    
//     func addToManyArray<T: NSManagedObject & RelationalEntity>(_ itemToAdd: T, _ relationship: ToManyEnum) {
//         switch relationship {
//             // self.addTo<#objects#>(itemToAdd.castedAs<#Entity#>())
//         }
//     }
    
// }



// MARK: - ObjectPlaceholderCompatible Conformance

extension Item: ObjectPlaceholderCompatible {
    
    var placeholderObjectName: String { unwrapped<#property#> }
    
    var placeholderEntityType: EntityType { .<#entityType#> }
    
}

// MARK: - RelationalPlaceholderObject Conformance

extension Item: RelationalPlaceholderObject {
    
}