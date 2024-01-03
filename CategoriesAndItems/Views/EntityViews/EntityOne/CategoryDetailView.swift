//
//  CategoryDetailView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct CategoryDetailView: View {

    init(_ category: Category) {
        self.category = category
    }
    
    @ObservedObject var category: Category
    
    @EnvironmentObject var vem: ViewEditingManager
    
    
    var body: some View {
        
        
        List {


            if vem.editMode == .inactive {
                Text(category.unwrappedName.capitalized)
            } else {
                TextField("New Name", text: $category.name.defaultValue(""))
            }
            
            

            // if vem.editMode == .inactive {
            //     Text(category.unwrapped<#property#>.capitalized)
            // } else {
            //     TextField("New <#property#>", text: $category.<#property#>.defaultValue("Optional Fail"))
            // }


            // Section("Item") {
            //     if vem.editMode == .inactive {
            //             if let item = category.item {
            //                 NavigationLink {
            //                     ItemDetailView(item)
            //                 } label: {
            //                     GenericViewManager.itemListRowView(item)
            //                 }
            //                 .disabled(vem.isEditing)
            //             } else {
            //                 Button("Choose Item") { vem.activeEditMode() }
            //             }
            //         } else {
            //             ToOnePickerParentView(objectSelection: $category.item, entityType: .item, context: vem.context)
            //         }
            // }





            

            Section {
                ForEach(category.itemsArray) { item in
                    NavigationLink {
                        ItemDetailView(item)
                    } label: {
                        GenericViewManager.tagListRowView(item)
                    }
//                    .disabled(vem.isEditing)

                }
                
            } header: {
                HStack {
                    Text("Item")
                    Spacer()
                    if vem.editMode == .active {
                        NavigationLink {
                            ToManyListParentView(object: category, selectedObjects: $category.items, toManyFilterType: .manyToMany, relationshipName: .items)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }   
                }
            }
            
                

            
        }
        
        .navigationTitle(category.unwrapped<#property#>.capitalized)

        
    }
}


#Preview {
    NavigationStack {
        CategoryDetailView(CoreDataPreviewManager.fetchPreviewObject(.category))
            .environmentObject(ViewEditingManager(CoreDataManager.preview.container.viewContext))
    }
}
