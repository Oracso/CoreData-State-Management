//
//  SettingsView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        
        List {
            
            NavigationLink("Download Data") {
                DataDownloadView()
            }
            
        }
        
        .navigationTitle("Settings")
      
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
