//
//  CustomUUID.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


protocol CustomUUID: Identifiable  {
    var customUUID: String { get }
}


struct CustomUUIDManager {
    static func separateCustomUUID(_ customUUID: String) -> (uuid: String, entityType: EntityType) {
        
        let split = customUUID.split(separator: "_")
        
        let stringUUID = split.first!
        let entityTypeString = split.last!
        
        let entityType = EntityType(rawValue: String(entityTypeString))
        
        // TODO: FORCE UNWRAP
        return (String(stringUUID), entityType!)
    }
}

extension CustomUUID {
    func separateCustomUUID() -> (uuid: String, entityType: EntityType) {
        return CustomUUIDManager.separateCustomUUID(customUUID)
    }
}


// TODO: Is this needed?
extension CustomUUID {
    func emptyCustomUUID() -> String {
        ""
    }
}



extension String {
    func separateCustomUUID() -> (uuid: String, entityType: EntityType) {
        return CustomUUIDManager.separateCustomUUID(self)
    }
}


extension NSManagedObject: CustomUUID {
    var customUUID: String {
        "\(String(describing: value(forKey: "id") as? UUID))_\(entity.name ?? "entity description unwrap fail)")"
    }
}

extension Array where Array == [NSManagedObject] {
    func returnObjectFromCustomUUID(_ customUUID: String) -> NSManagedObject? {
        self.first(where: { $0.customUUID == customUUID})
    }
}

extension Array where Array == [NSManagedObject] {
    func returnCustomUUIDsFromObjects() -> [String] {
        var array: [String] = []
        for object in self {
            array.append(object.customUUID)
        }
        return array
    }
}

extension NSSet {
    func returnCustomUUIDsFromConformingNSSet() -> [String] {
        let mapped = compactMap { $0 as? (any CustomUUID) }
        return mapped.returnCustomUUIDsFromConformingObjects()
    }
}

extension Array where Array == [ObjectPlaceholderDetails] {
    func returnCustomUUIDsFromObjectPlaceholders() -> [String] {
        var array: [String] = []
        for objectDetails in self {
            array.append(objectDetails.customUUID)
        }
        return array
    }
}

extension Array {
    func returnCustomUUIDsFromConformingObjects() -> [String] {
        if let conformingObjects = self as? [any CustomUUID] {
            var array: [String] = []
            for object in conformingObjects {
                array.append(object.customUUID)
            }
            return array
        } else {
            return []
        }
    
    }
}