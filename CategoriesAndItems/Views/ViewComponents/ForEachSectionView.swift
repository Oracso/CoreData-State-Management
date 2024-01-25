//
//  ForEachSectionView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct ForEachSectionView<T: NSManagedObject & RelationalEntity, U: RawRepresentable<String>>: View where T.EntityRelationships == U {
    
    @EnvironmentObject var vem: ViewEditingManager
    
    let sectionTitle: String
    
    @ObservedObject var parentObject: T
    
    @Binding var selectedObjects: NSSet?
    
    let selectedObjectsEntityType: EntityType
    
    var objectsEntityType: NSManagedObject.Type {
        selectedObjectsEntityType.entityClass()
    }
    
    let toManyFilterType: ToManyFilterType
    
    let relationshipName: U
    
    var inverseRelationshipName: String {
        parentObject.inverseRelationshipName(relationshipName)
    }
    

    var body: some View {
        
        
        Section {
            ForEach(selectedObjects.unwrap(objectsEntityType).sorted(by: {$0.customUUID < $1.customUUID})) { childObject in
                NavigationLink {
                    XDetailView(childObject)
                } label: {
                    GenericViewManager.objectListRowView(childObject)
                }
                    .disabled(vem.isEditing)
                
                
            }
        } header: {
            HStack {
                Text(sectionTitle)
                Spacer()
                if vem.editMode == .active {
                    NavigationLink {
                        ToManyListParentView(parentCustomUUID: parentObject.customUUID, selectedObjects: $selectedObjects, selectedObjectsEntityType: selectedObjectsEntityType, toManyFilterType: toManyFilterType, inverseRelationshipName: inverseRelationshipName)
                            .environment(\.managedObjectContext, vem.context)
                            .environmentObject(vem)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
        
        
        
    }
}


//#Preview {
//    
//    let parentObject = CoreDataPreviewManager.fetchPreviewObject(.category).castedAsCategory()
//    
//    let previewView = NavigationStack {
//        List {
//            ForEachSectionView(sectionTitle: "Items", parentObject: parentObject, selectedObjects: .createBinding(parentObject.items), selectedObjectsEntityType: .item, toManyFilterType: .oneToMany, relationshipName: .items)
//            .environmentObject(ViewEditingManager(CoreDataManager.preview.container.viewContext))
//            
//        }
//    }
//    
//    return previewView
//    
//}
