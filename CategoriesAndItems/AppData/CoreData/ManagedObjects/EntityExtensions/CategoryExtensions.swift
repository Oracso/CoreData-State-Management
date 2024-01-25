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

    public var unwrappedName: String {
        name ?? "name found nil"
    }
    

     public var unwrappedDate: Date {
         date ?? .now
     }
    

    
    
}


// MARK: - ObjectStore FetchRequest

extension Category {
    
    public class func objectStoreFetchRequest() -> NSFetchRequest<Category> {
        let request = NSFetchRequest<Category>(entityName: "Category")
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return request
    }
    
    
    
    
    
}









// MARK: - RelationalEntity Conformance

extension Category: RelationalEntity {
    
    typealias EntityRelationships = Relationships
 
    enum Relationships: String, CaseIterable, CardinalRelationships {
        case items, itemTags, mainItem

        typealias ToOneRelationships = ToOne
        
        enum ToOne: CaseIterable {
            case mainItem
        }
        
        typealias ToManyRelationships = ToMany
        
        enum ToMany: CaseIterable {
            case items, itemTags
        }

    }
    
    func returnRelationship(_ relationship: Relationships) -> ObjectOrNSSet {
        switch relationship {
        case .items:
            return ObjectOrNSSet(nSSet: items)
        case .itemTags:
            return ObjectOrNSSet(nSSet: itemTags)
        case .mainItem:
            return ObjectOrNSSet(object: mainItem)
        }
    }
    
    func returnRelationshipEntityType(_ relationship: Relationships) -> EntityType {
        switch relationship {
        case .items:
            return .item
        case .itemTags:
            return .item
        case .mainItem:
            return .item
        }
    }
    
    func inverseRelationshipName(_ relationship: Relationships) -> String {
        switch relationship {
        case .items:
            return "category"
        case .itemTags:
            return "categoryTags"
        case .mainItem:
            return "mainCategory"
        }
    }
    
}

// MARK: - ToManyEntity Conformance

 extension Category: ToManyEntity {
    
     typealias ToManyEnum = EntityRelationships.ToManyRelationships
    
     func addToManyArray<T: NSManagedObject & RelationalEntity>(_ itemToAdd: T, _ relationship: ToManyEnum) {
         switch relationship {
         case .items:
             self.addToItems(itemToAdd.castedAsItem())
         case .itemTags:
             self.addToItemTags(itemToAdd.castedAsItem())
         }
     }
    
 }



// MARK: - ObjectPlaceholderCompatible Conformance

extension Category: ObjectPlaceholderCompatible {
    
    var placeholderObjectName: String { unwrappedName }
    
    var placeholderEntityType: EntityType { .category }
    
}

// MARK: - RelationalPlaceholderObject Conformance

extension Category: RelationalPlaceholderObject {
    
}
