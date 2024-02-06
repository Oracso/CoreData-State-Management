//
//  ViewEditingManager.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import SwiftUI
import CoreData

class ViewEditingManager: ObservableObject {
    
    internal init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    let context: NSManagedObjectContext
    
    @Published var editMode: EditMode = .inactive

    // MARK: - Save/Discard Context
    
    @Published var cancelChanges = false
    
    func discardChanges() {
        context.rollback()
//        context.undo()
        inactiveEditMode()
    }
    
    func saveChanges() {
        context.saveIfChanges()
        inactiveEditMode()
    }
    
    // MARK: - Delete Object
    
    @Published var forDelete = false
    
    func deleteObject(_ object: NSManagedObject) {
        context.delete(object)
        forDelete = false
        saveChanges()
    }
    
    // MARK: - View UI
    
    @Published var backButton: Bool = false
    
    func toggleBackButton() {
        if editMode == .inactive {
            backButton = false
        } else if editMode == .active {
            backButton = true
        } else {
            backButton = false
        }
    }
    
    // MARK: - Check Object Can Save
    
    @Published var cantSave: Bool = false
    
    
    // MARK: - Change EditMode
    
    @Published var isEditing = false

    func activeEditMode() {
        editMode = .active
        isEditing = true
    }
    
    func inactiveEditMode() {
        editMode = .inactive
        isEditing = false
    }
    
     
    // MARK: - Child Context
    
    var object: NSManagedObject?
    
}
