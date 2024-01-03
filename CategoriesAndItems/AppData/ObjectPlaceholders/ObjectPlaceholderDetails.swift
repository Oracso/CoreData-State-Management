//
//  ObjectPlaceholderDetails.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData

struct ObjectPlaceholderDetails: ObjectPlaceholder {
    
    var objectName: String
    
    var customUUID: String
    
    var entityType: EntityType
    
    var toOneRelationships: ToOneRelationships = [:]
    
    var toManyRelationships: ToManyRelationships = [:]
    
    var id: String { customUUID }
    
}


extension ObjectPlaceholderDetails {
    static let emptyCustomUUID = ""
}




// MARK: - Check For Relationships

extension ObjectPlaceholderDetails {
    
    func checkForAnyRelationship(_ customUUID: String,  _ relationshipName: String) -> Bool {
        if checkForToOneRelationship(customUUID, relationshipName) || checkForToManyRelationship(customUUID, relationshipName) == true {
            return true
        } else {
            return false
        }
    }
    
    func checkForToManyRelationship(_ customUUID: String, _ relationshipName: String) -> Bool {
            let separated = customUUID.separateCustomUUID()
            if let entityToManyUUIDs = toManyRelationships[separated.entityType] {
                if let relationshipUUIDs = entityToManyUUIDs[relationshipName] {
                    if relationshipUUIDs.contains(where: {$0 == customUUID}) {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    
        func checkForToOneRelationship(_ customUUID: String, _ relationshipName: String) -> Bool {
            let separated = customUUID.separateCustomUUID()
            if let entityToOneUUIDs = toOneRelationships[separated.entityType] {
                if let relationshipUUID = entityToOneUUIDs[relationshipName] {
                    if relationshipUUID == customUUID {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    
}
