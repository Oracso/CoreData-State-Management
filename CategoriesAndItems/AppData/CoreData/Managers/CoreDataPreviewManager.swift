//
//  CoreDataPreviewManager.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData
import SwiftUI


struct CoreDataPreviewManager {
    
    init(_ context: NSManagedObjectContext, isStatic: Bool = false) {
        self.context = context
        self.fetcher = CoreDataFetcher(context)
        self.modifier = CoreDataModifier(context)
        
        
        if isStatic == false {
            initExampleData()
        }
    }
    
    let context: NSManagedObjectContext
    
    var fetcher: CoreDataFetcher
    
    var modifier: CoreDataModifier
    
    
    
    func initExampleData() {

        createAllExampleObjects([.category, .item], 5)
        
        // Add entity relationships

        linkOneToManyEntities(Category.self, Item.self, .items)
        linkOneToManyEntities(Category.self, Item.self, .itemTags)
        
        linkOneToManyEntities(Item.self, Category.self, .categoryTags)
        
        context.saveIfChanges()
    }
    
    
    
    
    // MARK: - Create Randomised Object Data
    
    private func createRandomisedObjects<T: NSManagedObject>(_ entityType: EntityType, _ quantity: Int) -> [T] {
        
        var examples: [T] = []
        
        let edg = ExampleDataGenerator()
        let randomisedObjects = edg.createAllRandomisedObjects(entityType.withSpaces, quantity)
        
        for random in randomisedObjects {
            examples.append(createObjectFromRandomisedObjectData(entityType: entityType, random))
        }
        
        return examples
        
    }
    
    // MARK: - Create Object from Randomised Data
    
    private func createObjectFromRandomisedObjectData<T: NSManagedObject>(entityType: EntityType, _ ran: RandomisedObjectData) -> T {
        
        switch entityType {
        case .category:
            return modifier.createCategory(name: ran.name, date: ran.indexedDate, details: nil, value: ran.int64) as! T
        case .item:
            return modifier.createItem(name: ran.name, date: ran.indexedDate, details: nil, value: ran.int64) as! T
        }
        
    }
    
    
    // MARK: - Create Entities
    
    func createAllExampleObjects(_ entityTypes: [EntityType], _ quantity: Int) {
        for entityType in entityTypes {
            let _ = createRandomisedObjects(entityType, quantity)
        }
    }
    
    
    // MARK: - Generic Create Entity Relationships
    
    
    func linkOneToManyEntities<T: NSManagedObject & RelationalEntity & ToManyEntity, U: NSManagedObject & RelationalEntity, Q>(_ oneEntity: T.Type,_ manyEntity: U.Type, _ relationship: Q) where Q == T.ToManyEnum {
        
        let oneEntityType: EntityType = .init(classType: oneEntity)
        let manyEntityType: EntityType = .init(classType: manyEntity)
        
        var allOnes: [T] { fetcher.fetchAllObjects(oneEntityType) as! [T] }
        var allManys: [U] { fetcher.fetchAllObjects(manyEntityType) as! [U] }
        
        var onesCount: Int { allOnes.count }
        var manysCount: Int { allManys.count }
        
        for manyItem in allManys {
            var oneIndex: Int {
                let lastIndex = onesCount-1
                return (0...lastIndex).randomElement() ?? 0
            }
            
            allOnes[oneIndex].addToManyArray(manyItem, relationship)
            
        }
        
    }
    
    
    
    // MARK: - SwiftUI Preview Code
    
    static var previewManager: CoreDataPreviewManager {
        CoreDataPreviewManager(CoreDataManager.preview.container.viewContext, isStatic: true)
    }
    
    
    
    // MARK: - All Preview Objects
    
    static func fetchAllPreviewObjects<T: NSManagedObject>(_ entityType: EntityType) -> [T] {
        previewManager.fetcher.fetchAllObjects(entityType) as! [T]
    }
    
    
    
    // MARK: - Single Preview Object
    
    
    static func fetchPreviewObject<T: NSManagedObject>(_ entityType: EntityType) -> T {
        let fetched = previewManager.fetcher.fetchObject(entityType)
        if let fetched {
            return fetched as! T
        } else {
            return previewManager.modifier.createEntity(entityType) as! T
        }
    }




    // MARK: - Fetch Object With Binding
    
    static func fetchObjectWithBinding<T: NSManagedObject>(_ entityType: EntityType) -> Binding<T> {
        var object: T
        switch entityType {
        case .category:
            object = fetchPreviewObject(.category)
        case .item:
            object = fetchPreviewObject(.item)
        }
        
        return createObjectBinding(object)
    }
    
    
    static private func createObjectBinding<T: NSManagedObject>(_ value: T) -> Binding<T> {
        var bindingValue = value
        return Binding(
            get: { bindingValue },
            set: { newValue in
                bindingValue = newValue
            }
        )
    }
    
    
    
    // MARK: - ObjectPlaceholder Examples
    
    static func allEntityObjectPlaceholderExamples(_ entityType: EntityType) -> [ObjectPlaceholderDetails] {
        let objects = self.fetchAllPreviewObjects(entityType)
        return ObjectPlaceholderDetailsManager().createAllEntityObjectPlaceholderDetails(objects)
    }


    
}


