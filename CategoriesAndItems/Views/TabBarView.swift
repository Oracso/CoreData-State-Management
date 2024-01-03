//
//  TabBarView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var ads: AppDataStore
    
    var body: some View {
        TabView {
            AllXView(ads.allObjects(.category), .category)
                .tabItem {
                    Label("Categories", systemImage: "bookmark")
                }
            
            AllXView(ads.allObjects(.item), .item)
                .tabItem {
                    Label("Items", systemImage: "book")
                }
            
             
        }
        
    }
}

#Preview {
    TabBarView()
        .environmentObject(AppDataStore(CoreDataManager.preview.container.viewContext))
}
