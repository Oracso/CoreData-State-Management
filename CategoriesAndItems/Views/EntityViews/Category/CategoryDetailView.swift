
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
    
    
    // MARK: Delete Object
    @Environment(\.dismiss) private var dismiss


    var body: some View {
        
        
        List {
            
            // MARK: Name
            // if vem.editMode == .inactive {
            //     Text(category.unwrappedName.capitalized)
            // } else {
            //     TextField("Name", text: $category.name.defaultValue(""))
            // }

            // MARK: Date
            // if vem.editMode == .inactive {
            //     Text(category.unwrappedDate.formatted(date: .abbreviated, time: .shortened))
            // } else {
            //     DatePicker("Date", selection: $category.date.defaultValue(.now), displayedComponents: [.date, .hourAndMinute])
            // }


            // MARK: Numeric
            // if vem.editMode == .inactive {
            //     Text(String(category.unwrapped<#property#>))
            // } else {
            //     NumberTextFieldView($category.<#property#>)
            // }

            
            // MARK: Empty String
            // if vem.editMode == .inactive {
            //     Text(category.unwrapped<#property#>.capitalized)
            // } else {
            //     TextField("<#property#>", text: $category.<#property#>.defaultValue(""))
            // }

            // MARK: Notes
            // TODO: Need to decide how I manage optional notes
            // if vem.editMode == .inactive {
            //     if let notes = category.notes {
            //         Text(notes)
            //     }
            // } else {
            //     TextField("Notes", text: $category.notes.defaultValue(""))
            // }


            // MARK: To-One Picker
            // PickerSectionView(sectionTitle: "<#property#>", selectedObject: $category.<#property#>, selectedObjectEntityType: .<#property#>)


            // MARK: To-Many List
            // ForEachSectionView(
            //     sectionTitle: "<#property#>",
            //     parentObject: category,
            //     selectedObjects: $category.<#property#>,
            //     selectedObjectsEntityType: .<#property#>,
            //     toManyFilterType: .<#type#>,
            //     relationshipName: .<#property#>
            // )
            

              // MARK: Delete Object 
            Section {
                GenericDeleteObjectButton(category, dismiss)
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