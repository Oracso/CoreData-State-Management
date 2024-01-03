//
//  AppDataStore.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData

class AppDataStore: ObservableObject {
    
    let context: NSManagedObjectContext
    
    @Published var refreshID = UUID()
    
    @Published var objects: AppObjectStores
    
    let fetcher: CoreDataFetcher
    let modifier: CoreDataModifier
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        self.objects = AppObjectStores(context)
        self.fetcher = CoreDataFetcher(context)
        self.modifier = CoreDataModifier(context)
        
        // Load Starting Data
        
        // Validate Existing Data
        
        // Save Context
        
    }
    
    
}



extension AppDataStore {
    func refresh() { refreshID = UUID() }
}


// MARK: - Generic All Object Calls/Returns?

extension AppDataStore {
    func allObjects(_ entityType: EntityType) -> [NSManagedObject] {
        objects.allObjects(entityType)
    }
}




// MARK: - CustomUUID Functionality

extension AppDataStore {
    
    func returnObjectFromAllCustomUUIDs(_ customUUID: String) -> NSManagedObject? {
        objects.returnObjectFromAllCustomUUIDs(customUUID)
    }
    
    func returnObjectsFromAllCustomUUIDs(_ customUUIDs: [String]) -> [NSManagedObject] {
        var array: [NSManagedObject] = []
        for customUUID in customUUIDs {
            if let object = returnObjectFromAllCustomUUIDs(customUUID) {
                array.append(object)
            }
        }
        return array
    }
    
}


// MARK: - Check Object Can Save Conditions
 
extension AppDataStore {
    
    func checkCanSave(_ entityType: EntityType, object: NSManagedObject) -> Bool {
        switch entityType {
        case .category:
            checkCanSaveCategory(object.castedAsCategory())
        case .item:
            checkCanSaveItem(object.castedAsItem())
        }
        
    }
    
    private func checkCanSaveCategory(_ object: Category) -> Bool {
        objects.categoryOS.categories.contains(where: { $0.<#property#> == object.<#property#> })
    }
    
    private func checkCanSaveItem(_ object: WordDefinition) -> Item {
        objects.itemOS.items.contains(where: { $0.<#property#> == object.<#property#> })
    }
    
    
}

