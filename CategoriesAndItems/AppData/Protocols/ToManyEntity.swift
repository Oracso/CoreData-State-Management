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


// protocol ToManyEntity {
//     func addToManyArray<T: NSManagedObject, U: NSManagedObject>(_ item: T, _ u: U.Type)
// }


// // Category -> [Item]
// extension Category: ToManyEntity {
//     func addToManyArray<T, U>(_ item: T, _ u: U.Type) where T : NSManagedObject, U : NSManagedObject {
//         self.addToItems(item as! Item)
//     }
    
// }


