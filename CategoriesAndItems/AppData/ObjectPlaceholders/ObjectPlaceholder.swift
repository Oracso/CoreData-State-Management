//
//  ObjectPlaceholder.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation


protocol ObjectPlaceholder: CustomUUID, Hashable {
    
    var objectName: String { get }
    
    var customUUID: String { get }
    
    var entityType: EntityType { get }
    
    var toOneRelationships: ToOneRelationships { get }
    
    var toManyRelationships: ToManyRelationships { get }
    
}

extension ObjectPlaceholder {
    typealias ToOneRelationships = [EntityType : ToOneUUIDs]
    typealias ToOneUUIDs = [String : String?]
    
    typealias ToManyRelationships = [EntityType: ToManyUUIDs]
    typealias ToManyUUIDs = [String: [String]]
}


protocol ObjectPlaceholderCompatible {
    var placeholderObjectName: String { get }
    var placeholderEntityType: EntityType { get }
}

protocol RelationalPlaceholderObject: NSManagedObject & RelationalEntity & ObjectPlaceholderCompatible {
    
}
