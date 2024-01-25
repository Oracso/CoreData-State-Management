//
//  NSManagedObject.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData

public typealias NSManagedObject = CoreData.NSManagedObject

extension NSManagedObject {
    
    
    class func customObjectsFetchRequest(_ type: FetchRequestType, context: NSManagedObjectContext) -> [NSManagedObject] {
        
        let fetchRequest = customiseFetchRequest(type)
        
        let examples: [NSManagedObject]
        
        do {
            examples = try context.fetch(fetchRequest)
        } catch {
            examples = []
        }
        
        return examples
        
    }
    
    class func singleObjectFetchRequest(context: NSManagedObjectContext) -> NSManagedObject? {
        
        let fetchRequest = customiseFetchRequest(.single)
        
        let example: NSManagedObject?
        
        do {
            example = try context.fetch(fetchRequest).first
        } catch {
            example = nil
        }
        
        return example
        
    }
    
  
    
    
    
    class private func customiseFetchRequest(_ type: FetchRequestType) -> NSFetchRequest<NSManagedObject> {
        
        let request = NSFetchRequest<NSManagedObject>(entityName: entity().name ?? "Unwrap Fail")
        
        switch type {
        case .single:
            request.fetchLimit = 1
        case .all:
            print("")
        case .objectStore:
            print("")
        }
        
        return request
    }
    
    
    enum FetchRequestType {
        case single
        case all
        case objectStore
    }
    
    
    
    
}


extension NSManagedObject: Identifiable {
    
}


// extension NSManagedObject {
    
//      func returnChildContext(_ context: NSManagedObjectContext) -> NSManagedObjectContext {
//         // Initialize Managed Object Context
//         let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

//         // Configure Managed Object Context
//         childContext.parent = context

//         return childContext
//     }
    
    
// }


// MARK: - Class Casting

extension NSManagedObject {
    
    func castedAsCategory() -> Category {
        self as! Category
    }
    
    func castedAsItem() -> Item {
        self as! Item
    }
    
    
    
    
}



extension Array where Array == [NSManagedObject] {
    func asNSSet() -> NSSet {
        NSSet(array: self)
    }
}


// MARK: - Unwrap NSSet? to [T]

extension Optional where Wrapped == NSSet {
    func unwrap<T: NSManagedObject>(_ classType: T.Type) -> [T] {
        guard let set = self as? Set<T> else {
            return []
        }
        return Array(set)
    }
}


extension NSManagedObjectContext {
    convenience init(_ parentContext: NSManagedObjectContext, _ mergeFromParent: Bool = true) {
        self.init(concurrencyType: .mainQueueConcurrencyType)
        self.automaticallyMergesChangesFromParent = mergeFromParent
        self.parent = parentContext
    }
}


