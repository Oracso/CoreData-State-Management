//
//  ToManyEntity.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData

protocol ToManyEntity {

    associatedtype ToManyEnum: CaseIterable
    
    func addToManyArray<T: NSManagedObject & RelationalEntity>(_ itemToAdd: T, _ relationship: ToManyEnum)
    
}
