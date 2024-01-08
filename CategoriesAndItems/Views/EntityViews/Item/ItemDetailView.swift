
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
    
    
    // MARK: Delete Object
    @Environment(\.dismiss) private var dismiss


    var body: some View {
        
        
        List {
            
            // MARK: Name
            // if vem.editMode == .inactive {
            //     Text(item.unwrappedName.capitalized)
            // } else {
            //     TextField("Name", text: $item.name.defaultValue(""))
            // }

            // MARK: Date
            // if vem.editMode == .inactive {
            //     Text(item.unwrappedDate.formatted(date: .abbreviated, time: .shortened))
            // } else {
            //     DatePicker("Date", selection: $item.date.defaultValue(.now), displayedComponents: [.date, .hourAndMinute])
            // }


            // MARK: Numeric
            // if vem.editMode == .inactive {
            //     Text(String(item.unwrapped<#property#>))
            // } else {
            //     NumberTextFieldView($item.<#property#>)
            // }

            
            // MARK: Empty String
            // if vem.editMode == .inactive {
            //     Text(item.unwrapped<#property#>.capitalized)
            // } else {
            //     TextField("<#property#>", text: $item.<#property#>.defaultValue(""))
            // }

            // MARK: Notes
            // TODO: Need to decide how I manage optional notes
            // if vem.editMode == .inactive {
            //     if let notes = item.notes {
            //         Text(notes)
            //     }
            // } else {
            //     TextField("Notes", text: $item.notes.defaultValue(""))
            // }


            // MARK: To-One Picker
            // PickerSectionView(sectionTitle: "<#property#>", selectedObject: $item.<#property#>, selectedObjectEntityType: .<#property#>)


            // MARK: To-Many List
            // ForEachSectionView(
            //     sectionTitle: "<#property#>",
            //     parentObject: item,
            //     selectedObjects: $item.<#property#>,
            //     selectedObjectsEntityType: .<#property#>,
            //     toManyFilterType: .<#type#>,
            //     relationshipName: .<#property#>
            // )
            

              // MARK: Delete Object 
            Section {
                GenericDeleteObjectButton(item, dismiss)
            }
                

            
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