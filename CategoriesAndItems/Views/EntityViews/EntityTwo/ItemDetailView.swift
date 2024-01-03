//
//  ItemDetailView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct ItemDetailView: View {

    init(_ item: Item) {
        self.item = item
    }
    
    @ObservedObject var item: Item
    
    @EnvironmentObject var vem: ViewEditingManager
    

    var body: some View {
        
        
            List {

                if vem.editMode == .inactive {
                    Text(item.unwrappedName.capitalized)
                } else {
                    TextField("New Name", text: $item.name.defaultValue(""))
                }
                
                // if vem.editMode == .inactive {
                //     Text(item.unwrapped<#property#>.capitalized)
                // } else {
                //     TextField("New <#property#>", text: $item.<#property#>.defaultValue("Optional Fail"))
                // }
                
               
                
                
            }
            
            
            
            .navigationTitle(item.unwrapped<#property#>.capitalized)

            
        
        
        
    }
    
  
}


#Preview {
    NavigationStack {
        ItemDetailView(CoreDataPreviewManager.fetchPreviewObject(.item))
            .environmentObject(ViewEditingManager(CoreDataManager.preview.container.viewContext))
    }
}