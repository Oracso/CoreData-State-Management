//
//  RelationalEntity.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation

protocol RelationalEntity {

    associatedtype EntityRelationships: RawRepresentable<String>, CaseIterable, CardinalRelationships
    
    func returnRelationship(_ relationship: EntityRelationships) -> ObjectOrNSSet
    
    func returnRelationshipEntityType(_ relationship: EntityRelationships) -> EntityType
    
    func inverseRelationshipName(_ relationship: EntityRelationships) -> String
    
}

enum ObjectOrNSSet {
    case object(NSManagedObject?)
    case nSSet(NSSet?)
}


extension ObjectOrNSSet {
    
    init(object: NSManagedObject?) {
        self = .object(object)
    }
    
    init(nSSet: NSSet?) {
        self = .nSSet(nSSet)
    }
    
}


protocol CardinalRelationships {
    associatedtype ToOneRelationships: CaseIterable
    associatedtype ToManyRelationships: CaseIterable
}
