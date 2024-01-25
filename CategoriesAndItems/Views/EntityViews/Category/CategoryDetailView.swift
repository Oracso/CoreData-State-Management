
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
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        List {
            
            // MARK: Name
             if vem.editMode == .inactive {
                 Text(category.unwrappedName.capitalized)
             } else {
                 TextField("Name", text: $category.name.defaultValue(""))
             }

            // MARK: Date
             if vem.editMode == .inactive {
                 Text(category.unwrappedDate.formatted(date: .abbreviated, time: .shortened))
             } else {
                 DatePicker("Date", selection: $category.date.defaultValue(.now), displayedComponents: [.date, .hourAndMinute])
             }

            // MARK: Details
             if vem.editMode == .inactive {
                 if let details = category.details {
                     Text(details)
                 }
             } else {
                 TextField("Details", text: $category.details.defaultValue(""))
             }


            // MARK: To-Many List
             ForEachSectionView(
                 sectionTitle: "Items",
                 parentObject: category,
                 selectedObjects: $category.items,
                 selectedObjectsEntityType: .item,
                 toManyFilterType: .oneToMany,
                 relationshipName: .items
             )
            
            // MARK: To-Many List
             ForEachSectionView(
                 sectionTitle: "Item Tags",
                 parentObject: category,
                 selectedObjects: $category.itemTags,
                 selectedObjectsEntityType: .item,
                 toManyFilterType: .manyToMany,
                 relationshipName: .itemTags
             )
            
            // MARK: To-One Picker
             PickerSectionView(sectionTitle: "Main Item", selectedObject: $category.mainItem, selectedObjectEntityType: .item)
            

              // MARK: Delete Object 
            Section {
                GenericDeleteObjectButton(category, dismiss)
            }
                

            
        }
        

    }
}


#Preview {
    NavigationStack {
        CategoryDetailView(CoreDataPreviewManager.fetchPreviewObject(.category))
            .environmentObject(ViewEditingManager(CoreDataManager.preview.container.viewContext))
    }
}
