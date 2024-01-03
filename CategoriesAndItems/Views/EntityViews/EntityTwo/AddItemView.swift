//
//  AddItemView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct AddItemView: View {
    
    init(_ item: Item) {
        self.item = item
    }
    
    @ObservedObject var item: Item
    
    @EnvironmentObject var vem: ViewEditingManager

    
    var body: some View {
    
        
        List {
            
            TextField("<#property#>", text: $item.<#property#>.defaultValue(<#property#>))
      
            
        }
        
        
        
        .navigationTitle("Add Item")
        
        
        
    }
}

#Preview {
    NavigationStack {
        AddItemView(ChildContextObjectContainer(CoreDataManager.preview.container.viewContext, .item).object.castedAsItem())
    }
}
