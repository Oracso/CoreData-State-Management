//
//  ItemObjectStore.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


class ItemObjectStore: NSObject, ObservableObject {
    
    @Published var items: [Item] = []
    private let controller: NSFetchedResultsController<Item>
    
    init(_ context: NSManagedObjectContext) {
        controller = NSFetchedResultsController(
            fetchRequest: Item.objectStoreFetchRequest(),
            managedObjectContext: context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        controller.delegate = self
        
        do {
            try controller.performFetch()
            items = controller.fetchedObjects ?? []
        } catch {
            print("failed to fetch items!")
        }
    }
}

extension ItemObjectStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedObjects = controller.fetchedObjects as? [Item]
        else { return }
        items = fetchedObjects
    }
}



