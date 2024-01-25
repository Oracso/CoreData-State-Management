//
//  PickerSectionView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct PickerSectionView<T: NSManagedObject>: View {
    
    @EnvironmentObject var vem: ViewEditingManager
    
    let sectionTitle: String
    
    @Binding var selectedObject: T?
    let selectedObjectEntityType: EntityType
    
    var body: some View {
        
        Section(sectionTitle) {
            if vem.editMode == .inactive {
                    if let unwrappedObject = selectedObject {
                        NavigationLink {
                            XDetailView(unwrappedObject)
                        } label: {
                            GenericViewManager.objectListRowView(unwrappedObject)
                        }
                        .disabled(vem.isEditing)
                    } else {
                        Text("No \(selectedObjectEntityType.rawValue.lowercased()) selected")
                    }
                } else {
                    ToOnePickerParentView(objectSelection: $selectedObject, entityType: selectedObjectEntityType, context: vem.context)
                }
        }
        
        
    }
}

#Preview {
    
    let parentObject = CoreDataPreviewManager.fetchPreviewObject(.item).castedAsItem()
    
    let previewView = List {
        PickerSectionView(sectionTitle: "Category", selectedObject: .createBinding(parentObject.category), selectedObjectEntityType: .category)
        .environmentObject(ViewEditingManager(CoreDataManager.preview.container.viewContext))
    }
    
    return previewView
    
}
