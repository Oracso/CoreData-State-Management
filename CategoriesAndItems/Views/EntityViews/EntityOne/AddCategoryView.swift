//
//  AddCategoryView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct AddCategoryView: View {
    
    init(_ category: Category) {
        self.category = category
    }
    
    @ObservedObject var category: Category
    
    @EnvironmentObject var vem: ViewEditingManager

    var body: some View {
        
        List {
            
            TextField("<#property#>", text: $category.<#property#>.defaultValue(<#property#>))
            


//             Section {
//                 ForEach(category.itemsArray) { item in
//                     NavigationLink {
//                         ItemDetailView(item)
//                     } label: {
//                         GenericViewManager.tagListRowView(item)
//                     }
// //                    .disabled(vem.isEditing)

//                 }
                
//             } header: {
//                 HStack {
//                     Text("Item")
//                     Spacer()
//                     if vem.editMode == .active {
//                         NavigationLink {
//                             ToManyListParentView(object: category, selectedObjects: $category.items, toManyFilterType: .manyToMany, relationshipName: .items)
//                                 .environment(\.managedObjectContext, vem.context)
//                                 .environmentObject(vem)
//                         } label: {
//                             Image(systemName: "plus")
//                         }
//                     }   
//                 }
//             }





        }
        
        .navigationTitle("Add Category")
        
        
    }
}

#Preview {
    NavigationStack {
        AddCategoryView(ChildContextObjectContainer(CoreDataManager.preview.container.viewContext, .category).object.castedAsCategory())
    }
}
