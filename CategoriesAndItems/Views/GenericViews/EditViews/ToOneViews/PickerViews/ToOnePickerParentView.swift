//
//  ToOnePickerParentView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI
import CoreData

struct ToOnePickerParentView<T: NSManagedObject>: View {
    
    @Binding var objectSelection: T?
    
    let entityType: EntityType

    let context: NSManagedObjectContext
    
    var fetcher: CoreDataFetcher { CoreDataFetcher(context) }
    
    @State private var selectedObjectCustomUUID: String?
    
    let odpm = ObjectPlaceholderDetailsManager()
    
    func allPlaceholderDetails() -> [ObjectPlaceholderDetails] {
        let objects = fetcher.fetchAllObjects(entityType)
        return odpm.createAllEntityObjectPlaceholderDetails(objects)
    }
    
    func setSelectedObjectCustomUUID() {
        if let objectSelection {
            selectedObjectCustomUUID = objectSelection.customUUID
        }
    }
    
    func setObjectSelection() {
        if let selectedObjectCustomUUID {
            let fetchedObject = fetcher.returnObjectFromAllCustomUUIDs(selectedObjectCustomUUID)
            objectSelection = fetchedObject as? T
        } else {
            objectSelection = nil
        }
    }
    
    
    
    var body: some View {
        
        
        ToOnePickerView(entityType: entityType, allPlaceholderDetails: allPlaceholderDetails(), selectedObjectCustomUUID: $selectedObjectCustomUUID)
        
            .onAppear() {
                setSelectedObjectCustomUUID()
            }
        
            .onChange(of: selectedObjectCustomUUID) {
                setObjectSelection()
            }
        
    }
}

#Preview {
    List {
        ToOnePickerParentView(
            objectSelection: Binding.createBinding(
                CoreDataPreviewManager.fetchPreviewObject(.item).castedAsItem().category
            ), 
            entityType: .category,
            context: CoreDataManager.preview.container.viewContext
        )
    }
}
