//
//  DataDownloadManager.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData

class DataDownloadManager: ObservableObject {
    
    let context: NSManagedObjectContext
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        self.fetcher = CoreDataFetcher(context)
    }

    
    let jsonManager = JSONManager()
    
    @Published var finalURLs: [URL] = []
    
    
    func writeObjectsAndAddURLToArray<T: Encodable>(_ objects: [T]) {
        let url = jsonManager.writeEntityObjectsToURL(objects)
        finalURLs.append(url)
    }
    
    
    let fetcher: CoreDataFetcher
    
    
}


class EntitySelectionTracker: ObservableObject {
    
    @Published var entities: [EntitySelection] = []
    
    func createSelections() {
       var array: [EntitySelection] = []
        for entity in EntityType.allCases {
           array.append(EntitySelection(entity: entity))
       }
        self.entities = array
   }
    
    struct EntitySelection: Identifiable {
        let entity: EntityType
        var selected: Bool = false
        var id: EntityType { entity }
    }
    
}



