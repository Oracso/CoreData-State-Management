//
//  GenericViewManager.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData
import SwiftUI

struct GenericViewManager {
   

    // MARK: - Entity Detail View


    @ViewBuilder func objectDetailView(_ object: NSManagedObject) -> some View {
        if let unwrappedEntityType = object.entityType() {
            switch unwrappedEntityType {
            case .category:
                CategoryDetailView(object.castedAsCategory())
            case .item:
                ItemDetailView(object.castedAsItem())
            }
        } else {
            nilDetailView()
        }
    }



    

    // MARK: - View Navigation Titles
    
    static func navTitle(_ entityType: EntityType) -> String {
        "All \(entityType.pluralRawValue())"
    }
    
    private func nilDetailView() -> some View {
        Text("No Entity Type Found")
    }
    
    private static func nilListRowView() -> some View {
        Text("No Entity Type Found")
    }
    
    
    
}


extension GenericViewManager {
    
    
    // MARK: - Add Object View
    
    @ViewBuilder func addObjectView(_ object: NSManagedObject) -> some View {
        if let unwrappedEntityType = object.entityType() {
            switch unwrappedEntityType {
            case .category:
                AddCategoryView(object.castedAsCategory())
            case .item:
                AddItemView(object.castedAsItem())
            }
        }
        
    }
    
    
}




// MARK: - Entity List Row Views

extension GenericViewManager {
    

     // MARK: - List Row View

    
    @ViewBuilder static func objectListRowView(_ object: NSManagedObject) -> some View {
        if let unwrappedEntityType = object.entityType() {
            switch unwrappedEntityType {
            case .category:
                categoryListRowView(object.castedAsCategory())
            case .item:
                itemListRowView(object.castedAsItem())
            }
        } else {
            nilListRowView()
        }
    }



    
    static func categoryListRowView(_ object: Category) -> some View {
        HStack {
            Text(object.unwrappedName.capitalized)
        }
    }
    
    
    static func itemListRowView(_ object: Item) -> some View {
        HStack {
            Text(object.unwrappedName.capitalized)
        }
    }
    
    
    
}


