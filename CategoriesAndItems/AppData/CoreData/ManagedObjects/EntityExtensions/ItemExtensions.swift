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
    
    public var unwrappedName: String {
        name ?? "name found nil"
    }
    
    
    public var unwrappedDate: Date {
        date ?? .now
    }
    
    
    
}


// MARK: - ObjectStore FetchRequest

extension Item {
    
    public class func objectStoreFetchRequest() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return request
    }
    
    
    
    
    
}






// MARK: - RelationalEntity Conformance

extension Item: RelationalEntity {
    
    typealias EntityRelationships = Relationships
    
    enum Relationships: String, CaseIterable, CardinalRelationships {
        case category, categoryTags, mainCategory
        
        typealias ToOneRelationships = ToOne
        
        enum ToOne: CaseIterable {
            case category, mainCategory
        }
        
        typealias ToManyRelationships = ToMany
        
        enum ToMany: CaseIterable {
            case categoryTags
        }
        
    }
    
    func returnRelationship(_ relationship: Relationships) -> ObjectOrNSSet {
        switch relationship {
        case .category:
            return ObjectOrNSSet(object: category)
        case .categoryTags:
            return ObjectOrNSSet(nSSet: categoryTags)
        case .mainCategory:
            return ObjectOrNSSet(object: mainCategory)
        }
    }
    
    func returnRelationshipEntityType(_ relationship: Relationships) -> EntityType {
        switch relationship {
        case .category:
            return .category
        case .categoryTags:
            return .category
        case .mainCategory:
            return .category
        }
    }
    
    func inverseRelationshipName(_ relationship: Relationships) -> String {
        switch relationship {
        case .category:
            return "items"
        case .categoryTags:
            return "itemTags"
        case .mainCategory:
            return "mainItem"
        }
    }
    
}

// MARK: - ToManyEntity Conformance

 extension Item: ToManyEntity {

     typealias ToManyEnum = EntityRelationships.ToManyRelationships

     func addToManyArray<T: NSManagedObject & RelationalEntity>(_ itemToAdd: T, _ relationship: ToManyEnum) {
         switch relationship {
         case .categoryTags:
             self.addToCategoryTags(itemToAdd.castedAsCategory())
         }
     }

 }



// MARK: - ObjectPlaceholderCompatible Conformance

extension Item: ObjectPlaceholderCompatible {
    
    var placeholderObjectName: String { unwrappedName }
    
    var placeholderEntityType: EntityType { .item }
    
}

// MARK: - RelationalPlaceholderObject Conformance

extension Item: RelationalPlaceholderObject {
    
}
