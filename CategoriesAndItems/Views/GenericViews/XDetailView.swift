//
//  XDetailView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI
import CoreData

struct XDetailView: View {
    
    init(_ object: NSManagedObject, _ editable: Bool = false) {
        self.object = object
        self.editable = editable
    }
    
    @ObservedObject var object: NSManagedObject
    
    let gvm = GenericViewManager()
    
    // MARK: - If view is editable
    
    let editable: Bool
    
    @EnvironmentObject var ads: AppDataStore
    
    @EnvironmentObject var vem: ViewEditingManager
    
    var saveButton: CustomButton { CustomButton(.save, OptionalFunc(saveFunc)) }
    var cancelButton: CustomButton { CustomButton(.cancel, OptionalFunc(cancelFunc)) }
    
    func saveFunc() {
        vem.saveChanges()
        ads.refresh()
    }
    
    func cancelFunc() {
        if vem.context.hasChanges {
            vem.cancelChanges.toggle()
        } else {
            vem.inactiveEditMode()
        }
    }
    
    func discardFunc() {
        vem.discardChanges()
    }
    
    var body: some View {
        
        if editable {
            gvm.objectDetailView(object)
                .standardGenericEditViewModifiers(vem, saveButton, cancelButton, OptionalFunc(discardFunc))
        } else {
            gvm.objectDetailView(object)
        }
        
    }
}

#Preview {
    NavigationStack {
        XDetailView(CoreDataPreviewManager.fetchPreviewObject(.category), true)
            .environmentObject(AppDataStore(CoreDataManager.preview.container.viewContext))
            .environmentObject(ViewEditingManager(CoreDataManager.preview.container.viewContext))
    }
}









