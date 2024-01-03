//
//  ToOnePickerView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct ToOnePickerView: View {
    
    let entityType: EntityType

    let allPlaceholderDetails: [ObjectPlaceholderDetails]
    
    @Binding var selectedObjectCustomUUID: String?
    
    var nilObjectPlaceholderDetails: ObjectPlaceholderDetails? = nil
    
    var entityTypeTitle: String {
        "Assign \(entityType.rawValue)"
    }
  
    var body: some View {

        Picker(selection: $selectedObjectCustomUUID) {
            
            Text("Unassigned")
                .tag(nilObjectPlaceholderDetails?.emptyCustomUUID())
            
            ForEach(allPlaceholderDetails) { objectDetails in
                Text(objectDetails.objectName.capitalized)
                    .tag(Optional(objectDetails.customUUID))
            }
            
            
        } label: {
            Text(entityTypeTitle)
        }
        
        
    }
}

#Preview {
    List {
        ToOnePickerView(entityType: .category, allPlaceholderDetails: CoreDataPreviewManager.allEntityObjectPlaceholderExamples(.category), selectedObjectCustomUUID: Binding.createBinding(""))
    }
}
