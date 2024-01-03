//
//  EntityRelationshipManager.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation

struct EntityRelationshipManager {
    
    
    func createRelationshipUUIDs<T: NSManagedObject & RelationalEntity>(_ object: T) -> (toOne: ToOneRelationships, toMany: ToManyRelationships) {
        
        var toOneDictionary: ToOneRelationships = [:]
        var toManyDictionary: ToManyRelationships = [:]
        
        for relationship in T.EntityRelationships.allCases {
            
            let entityType = object.returnRelationshipEntityType(relationship)
            
            let relationshipObjectOrSet: ObjectOrNSSet = object.returnRelationship(relationship)
            
            switch relationshipObjectOrSet {
            case .object(let typedObject):
                
                let customUUID = typedObject?.customUUID
                
                // Add to toOneDictionary
                if var entityTypeDic = toOneDictionary[entityType] {
                    entityTypeDic[relationship.rawValue] = customUUID
                    toOneDictionary[entityType] = entityTypeDic
                } else {
                    toOneDictionary[entityType] = [relationship.rawValue : customUUID]
                }
                
            case .nSSet(let typedSet):
                
                // Add to toManyDictionary
                if var entityTypeDic = toManyDictionary[entityType] {
                    if let unwrappedSet = typedSet {
                        entityTypeDic[relationship.rawValue] = unwrappedSet.returnCustomUUIDsFromConformingNSSet()
                    } else {
                        entityTypeDic[relationship.rawValue] = []
                    }
                    toManyDictionary[entityType] = entityTypeDic
                } else {
                    if let unwrappedSet = typedSet {
                        toManyDictionary[entityType] = [relationship.rawValue : unwrappedSet.returnCustomUUIDsFromConformingNSSet()]
                    } else {
                        toManyDictionary[entityType] = [relationship.rawValue : []]
                    }
                }
            }
            
        }
        
        return (toOneDictionary, toManyDictionary)
        
    }
    
}


extension EntityRelationshipManager {
    
    typealias ToOneRelationships = [EntityType : ToOneUUIDs]
    typealias ToOneUUIDs = [String : String?]
    
    typealias ToManyRelationships = [EntityType: ToManyUUIDs]
    typealias ToManyUUIDs = [String: [String]]
    
}
