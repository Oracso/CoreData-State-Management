
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
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        List {
            
            // MARK: Name
             if vem.editMode == .inactive {
                 Text(item.unwrappedName.capitalized)
             } else {
                 TextField("Name", text: $item.name.defaultValue(""))
             }

            // MARK: Date
             if vem.editMode == .inactive {
                 Text(item.unwrappedDate.formatted(date: .abbreviated, time: .shortened))
             } else {
                 DatePicker("Date", selection: $item.date.defaultValue(.now), displayedComponents: [.date, .hourAndMinute])
             }
            

            // MARK: Details
             if vem.editMode == .inactive {
                 if let details = item.details {
                     Text(details)
                 }
             } else {
                 TextField("Details", text: $item.details.defaultValue(""))
             }


            // MARK: To-One Picker
             PickerSectionView(sectionTitle: "Category", selectedObject: $item.category, selectedObjectEntityType: .category)


            // MARK: To-Many List
             ForEachSectionView(
                 sectionTitle: "Category Tags",
                 parentObject: item,
                 selectedObjects: $item.categoryTags,
                 selectedObjectsEntityType: .category,
                 toManyFilterType: .manyToMany,
                 relationshipName: .categoryTags
             )
            
            // MARK: To-One Picker
             PickerSectionView(sectionTitle: "Main Category", selectedObject: $item.mainCategory, selectedObjectEntityType: .category)
            

              // MARK: Delete Object 
            Section {
                GenericDeleteObjectButton(item, dismiss)
            }
                

            
        }
        

    }
}


#Preview {
    NavigationStack {
        ItemDetailView(CoreDataPreviewManager.fetchPreviewObject(.item))
            .environmentObject(ViewEditingManager(CoreDataManager.preview.container.viewContext))
    }
}
