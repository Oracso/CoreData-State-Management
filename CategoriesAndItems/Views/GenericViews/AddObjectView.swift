//
//  AddObjectView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI
import CoreData

struct AddObjectView: View {
    
    init(_ entityType: EntityType, _ context: NSManagedObjectContext) {
        self.entityType = entityType
        
        _childVEM = StateObject(wrappedValue: {
            let childContext = NSManagedObjectContext(context)
            print("AddObjectView _childVEM init childContext: \(childContext)")
            let cVEM = ViewEditingManager(childContext)
            cVEM.editMode = .active
            cVEM.backButton = true
            let modifier = CoreDataModifier(childContext)
            cVEM.object = modifier.createEntity(entityType)
            print("cVem context: \(cVEM.context)")
            return cVEM
        }())
        
    }
    
    @EnvironmentObject var ads: AppDataStore
    
    @Environment(\.dismiss) private var dismiss
    
    let entityType: EntityType
    
    let gvm = GenericViewManager()
    
    @StateObject var childVEM: ViewEditingManager
    
    var saveButton: CustomButton { CustomButton(.save, OptionalFunc(saveFunc)) }
    var cancelButton: CustomButton { CustomButton(.cancel, OptionalFunc(cancelFunc)) }
    
    func saveFunc() {
        if let object = childVEM.object {
            if ads.checkCanSave(entityType, object: object) == false {
                childVEM.context.saveIfChanges()
                ads.refresh()
                dismiss()
            } else {
                childVEM.cantSave = true
                print("Cannot save object")
            }
        }
    }
    
    func cancelFunc() {
        if childVEM.context.hasChanges {
            childVEM.cancelChanges.toggle()
        } else {
            childVEM.inactiveEditMode()
        }
    }
    
    func discardFunc() {
        childVEM.discardChanges()
        dismiss()
    }
    
    
    var body: some View {
        
        if let object = childVEM.object {
            gvm.addObjectView(object)
                .environmentObject(childVEM)
            
                .standardGenericEditViewModifiers(childVEM, saveButton, cancelButton, OptionalFunc(discardFunc))
            
                .unableToSaveObject(childVEM)
            
        } else {
            Text("No object found")
        }
        
    }
}

#Preview {
    NavigationStack {
        AddObjectView(.category, CoreDataManager.preview.container.viewContext)
            .environmentObject(AppDataStore(CoreDataManager.preview.container.viewContext))
    }
}
