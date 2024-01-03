//
//  ExampleDataGenerator.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreLocation


struct ExampleDataGenerator {
    
    func createRandomisedObject(_ name: String, _ index: Int,_ indexedName: Bool = true) -> RandomisedObjectData {
        
        var nameString: String {
            if indexedName {
                return "\(name) \(index)"
            } else {
                return name
            }
        }
      
        let randomised = RandomisedObjectData(name: nameString, index: index)
        
        return randomised
    }
    
    
    
    func createAllRandomisedObjects(_ name: String,_ quantity: Int) -> [RandomisedObjectData] {
        
        var array: [RandomisedObjectData] = []
        
        for index in 1...quantity {
            
            let item = createRandomisedObject(name, index)
            
            array.append(item)
        }
        return array
    }
    
    
    
}


