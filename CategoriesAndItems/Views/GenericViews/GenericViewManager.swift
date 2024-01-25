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
                    .navigationTitle(object.castedAsCategory().unwrappedName.capitalized)
            case .item:
                ItemDetailView(object.castedAsItem())
                    .navigationTitle(object.castedAsItem().unwrappedName.capitalized)
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

// MARK: - Add Object View

extension GenericViewManager {
    
    @ViewBuilder func addObjectView(_ object: NSManagedObject) -> some View {
        if let unwrappedEntityType = object.entityType() {
            switch unwrappedEntityType {
            case .category:
                CategoryDetailView(object.castedAsCategory())
                    .navigationTitle("Add \(object.entityTypeRawValue())")
            case .item:
                ItemDetailView(object.castedAsItem())
                    .navigationTitle("Add \(object.entityTypeRawValue())")
            }
        }
        
    }
    
}



// MARK: - Entity List Row Views

extension GenericViewManager {
    
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
            Spacer()
            Text("(\(object.items?.count ?? 0) items)")
        }
    }
    
    static func itemListRowView(_ object: Item) -> some View {
        HStack {
            Text(object.unwrappedName.capitalized)
            Spacer()
            if let cat = object.category {
                Text("(\(cat.unwrappedName.capitalized))")
            }
        }
    }
    
}


