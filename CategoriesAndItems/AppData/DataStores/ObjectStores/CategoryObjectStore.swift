//
//  CategoryObjectStore.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData

class CategoryObjectStore: NSObject, ObservableObject {
    
    @Published var categories: [Category] = []
    private let controller: NSFetchedResultsController<Category>
    
    init(_ context: NSManagedObjectContext) {
        controller = NSFetchedResultsController(
            fetchRequest: Category.objectStoreFetchRequest(),
            managedObjectContext: context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        controller.delegate = self
        
        do {
            try controller.performFetch()
            categories = controller.fetchedObjects ?? []
        } catch {
            print("failed to fetch categories!")
        }
    }
}

extension CategoryObjectStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedObjects = controller.fetchedObjects as? [Category]
        else { return }
        categories = fetchedObjects
    }
}
