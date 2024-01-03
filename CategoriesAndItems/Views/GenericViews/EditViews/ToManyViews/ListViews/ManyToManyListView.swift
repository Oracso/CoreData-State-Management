//
//  ManyToManyListView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI


struct ManyToManyListView: View {
    
    @ObservedObject var placeholderDetailsContainer: ObjectPlaceholderDetailsContainer
    
    @State private var updateContainer = false
    
    
    var body: some View {
        
        
        ForEach(placeholderDetailsContainer.allObjectPlaceholderDetailsToggles) { toggledObjectDetails in
            
            Button {
                toggledObjectDetails.toggle.toggle()
                updateContainer.toggle()
            } label: {
                Text(toggledObjectDetails.placeholderDetails.objectName.capitalized)
                    .buttonStyle(.bordered)
                    .tint(toggledObjectDetails.toggle ? .green : . red)
                
            }
                        
            
        }
        
        .id(updateContainer)
        
        
        
        
    }
}

#Preview {
    
    let parentObject = CoreDataPreviewManager.fetchPreviewObject(.category).castedAsCategory()
    // let allRelationshipObjects = CoreDataPreviewManager.fetchAllPreviewObjects(.item)
    // let allPlaceholderDetails = ObjectPlaceholderDetailsManager().createAllEntityObjectPlaceholderDetails(allRelationshipObjects)
    
    let vem = ViewEditingManager(CoreDataManager.preview.container.viewContext)
    vem.editMode = .active
    
    let previewView = NavigationStack {
        ToManyListParentView(parentCustomUUID: parentObject.customUUID, selectedObjects: .createBinding(parentObject.items), selectedObjectsEntityType: .item, toManyFilterType: .manyToMany, inverseRelationshipName: parentObject.inverseRelationshipName(.items))
    }
        .environmentObject(AppDataStore(CoreDataManager.preview.container.viewContext))
        .environmentObject(vem)
    
    return previewView
}
