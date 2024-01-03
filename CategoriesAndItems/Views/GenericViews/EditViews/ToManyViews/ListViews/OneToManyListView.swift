//
//  OneToManyListView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct OneToManyListView: View {
    
    @ObservedObject var placeholderDetailsContainer: ObjectPlaceholderDetailsContainer
    
    var entityTypeTitle: String {
        "Entities"
    }
    
    func reassignObjectDetails(_ removeFrom: RemoveFromType, _ indexInt: Int, _ assignTo: AssignToType) {
        let removed = removeObjectDetailsFrom(removeFrom, indexInt)
        assignObjectDetailsTo(removed, assignTo)
    }
    
    
    func removeObjectDetailsFrom(_ removeFrom: RemoveFromType, _ indexInt: Int) -> ObjectPlaceholderDetails {
        switch removeFrom {
        case .selected:
            placeholderDetailsContainer.selectedPlaceholderDetails.remove(at: indexInt)
        case .unassigned:
            placeholderDetailsContainer.unassignedPlaceholderDetails.remove(at: indexInt)
        case .assigned:
            placeholderDetailsContainer.assignedPlaceholderDetails.remove(at: indexInt)
        }
    }
    
    func assignObjectDetailsTo(_ objectDetails: ObjectPlaceholderDetails, _ assignTo: AssignToType) {
        switch assignTo {
        case .selected:
            placeholderDetailsContainer.selectedPlaceholderDetails.append(objectDetails)
        case .unassigned:
            placeholderDetailsContainer.unassignedPlaceholderDetails.append(objectDetails)
        case .assigned:
            placeholderDetailsContainer.assignedPlaceholderDetails.append(objectDetails)
        }
    }
    
    
    enum RemoveFromType {
        case selected
        case unassigned
        case assigned
    }
    
    enum AssignToType {
        case selected
        case unassigned
        case assigned
    }
    
    
    var body: some View {
        
        Section("Selected \(entityTypeTitle)") {
            ForEach(Array(placeholderDetailsContainer.selectedPlaceholderDetails.enumerated()), id: \.element.id) { (indexInt, objectDetails) in
                Button {
                    reassignObjectDetails(.selected, indexInt, .unassigned)
                } label: {
                    Text(objectDetails.objectName.capitalized)
                }
            }
        }
        
        
        Section("Unassigned \(entityTypeTitle)") {
            ForEach(Array(placeholderDetailsContainer.unassignedPlaceholderDetails.enumerated()), id: \.element.id) { (indexInt, objectDetails) in
                Button {
                    reassignObjectDetails(.unassigned, indexInt, .selected)
                } label: {
                    Text(objectDetails.objectName.capitalized)
                }
            }
            
        }
        
        Section("Assigned \(entityTypeTitle)") {
            ForEach(placeholderDetailsContainer.assignedPlaceholderDetails) { objectDetails in
                Text(objectDetails.objectName.capitalized)
            }
            
        }
        
        
        
        
    }
}


//#Preview {
//    
//    let parentObject = CoreDataPreviewManager.fetchPreviewObject(.<#EntityType#>).castedAs<#Entity#>()
//    let allRelationshipObjects = CoreDataPreviewManager.fetchAllPreviewObjects(.<#EntityType#>)
//    let allPlaceholderDetails = ObjectPlaceholderDetailsManager().createAllEntityObjectPlaceholderDetails(allRelationshipObjects, .<#EntityType#>)
//    
//    let vem = ViewEditingManager(CoreDataManager.preview.container.viewContext)
//    vem.editMode = .active
//    
//    let previewView = NavigationStack {
//        ToManyListParentView(parentCustomUUID: parentObject.customUUID, selectedObjects: .createBinding(parentObject.<#property#>), selectedObjectsEntityType: .<#EntityType#>, toManyFilterType: .oneToMany)
//    }
//        .environmentObject(AppDataStore(CoreDataManager.preview.container.viewContext))
//        .environmentObject(vem)
//    
//    return previewView
//}

