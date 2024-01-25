//
//  ObjectPlaceholderDetailsManager.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation

struct ObjectPlaceholderDetailsManager {
    
    
    // MARK: - Return PlaceholderDetails from AppDataStore
    
    func returnPlaceholderDetails(_ ads: AppDataStore, _ entityType: EntityType) -> [ObjectPlaceholderDetails] {
        let objects = ads.allObjects(entityType)
        return createAllEntityObjectPlaceholderDetails(objects)
    }
    
    
    // MARK: - Create PlaceholderDetails
    
    func createAllEntityObjectPlaceholderDetails(_ objects: [NSManagedObject]) -> [ObjectPlaceholderDetails] {
        let checkedObjects = checkForRelationalPlaceholderObjectConformance(objects)
        var array: [ObjectPlaceholderDetails] = []
        for object in checkedObjects {
            array.append(createObjectPlaceholderDetails(object))
        }
        return array
    }
    
    func checkForRelationalPlaceholderObjectConformance<T: NSManagedObject>(_ objects: [T]) -> [any RelationalPlaceholderObject] {
        if let conformingObjects = objects as? [any RelationalPlaceholderObject] {
            return conformingObjects
        } else {
            return []
        }
    }



    // MARK: - ObjectPlaceholderDetails Init()
    
    func createObjectPlaceholderDetails<T: RelationalPlaceholderObject>(_ object: T) -> ObjectPlaceholderDetails {
        let relationshipUUIDs = EntityRelationshipManager().createRelationshipUUIDs(object)
        return ObjectPlaceholderDetails(
            objectName: object.placeholderObjectName,
            customUUID: object.customUUID,
            entityType: object.placeholderEntityType,
            toOneRelationships: relationshipUUIDs.toOne,
            toManyRelationships: relationshipUUIDs.toMany
            )
    }
    
    
    // MARK: - Filter PlaceholderDetails by Selected/Unassigned/Assigned CustomUUIDs
    
    func filterPlaceholderDetailsByUnassignedAssignedAndSelf(_ filterType: ToManyFilterType , _ placeholderDetails: [ObjectPlaceholderDetails], _ parentCustomUUID: String, _ relationshipName: String) -> (assignedToSelf: [ObjectPlaceholderDetails], assigned: [ObjectPlaceholderDetails], unassigned: [ObjectPlaceholderDetails]) {
        switch filterType {
        case .oneToMany:
            filterManyToOnePlaceholderDetailsByUnassignedAssignedAndSelf(placeholderDetails, parentCustomUUID, relationshipName)
        case .manyToMany:
            filterManyToManyPlaceholderDetailsByUnassignedAssignedAndSelf(placeholderDetails, parentCustomUUID, relationshipName)
        }
    }
    
    
    private func filterManyToOnePlaceholderDetailsByUnassignedAssignedAndSelf(_ placeholderDetails: [ObjectPlaceholderDetails], _ parentCustomUUID: String, _ relationshipName: String) -> (assignedToSelf: [ObjectPlaceholderDetails], assigned: [ObjectPlaceholderDetails], unassigned: [ObjectPlaceholderDetails]) {
        let parentEntityType = parentCustomUUID.separateCustomUUID().entityType
        return placeholderDetails.reduce(into: ([ObjectPlaceholderDetails](), [ObjectPlaceholderDetails](), [ObjectPlaceholderDetails]())) { result, objectDetails in
            if let entityToOneUUIDs = objectDetails.toOneRelationships[parentEntityType] {
                if let relationshipUUID = entityToOneUUIDs[relationshipName] {
                    if let uuid = relationshipUUID {
                        if uuid == parentCustomUUID {
                            result.0.append(objectDetails)
                        } else {
                            result.1.append(objectDetails)
                        }
                    } else {
                        result.2.append(objectDetails)
                    }
                }
            }
        }
    }
    
    
    private func filterManyToManyPlaceholderDetailsByUnassignedAssignedAndSelf(_ placeholderDetails: [ObjectPlaceholderDetails], _ parentCustomUUID: String, _ relationshipName: String) -> (assignedToSelf: [ObjectPlaceholderDetails], assigned: [ObjectPlaceholderDetails], unassigned: [ObjectPlaceholderDetails]) {
        let parentEntityType = parentCustomUUID.separateCustomUUID().entityType
        return placeholderDetails.reduce(into: ([ObjectPlaceholderDetails](), [ObjectPlaceholderDetails](), [ObjectPlaceholderDetails]())) { result, objectDetails in
            if let entityToManyUUIDs = objectDetails.toManyRelationships[parentEntityType] {
                if let relationshipUUIDs = entityToManyUUIDs[relationshipName] {
                    if relationshipUUIDs.isEmpty == false {
                        if relationshipUUIDs.contains(where: {$0 == parentCustomUUID}) {
                            result.0.append(objectDetails)
                        } else {
                            result.1.append(objectDetails)
                        }
                    } else {
                        result.2.append(objectDetails)
                    }
                }
            }
        }
    }
    



}
