//
//  ToManyListParentView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI
import CoreData

struct ToManyListParentView: View {
    
    init<T: NSManagedObject & RelationalEntity, U: RawRepresentable<String>>(object: T, selectedObjects: Binding<NSSet?>, toManyFilterType: ToManyFilterType, relationshipName: U) where T.EntityRelationships == U {
        self.parentCustomUUID = object.customUUID
        _selectedObjects = selectedObjects
        self.selectedObjectsEntityType = object.returnRelationshipEntityType(relationshipName)
        self.toManyFilterType = toManyFilterType
        _placeholderDetailsContainer = StateObject(wrappedValue: ObjectPlaceholderDetailsContainer(object.customUUID, toManyFilterType))
        self.relationshipName = object.inverseRelationshipName(relationshipName)
    }
    
    init(parentCustomUUID: String, selectedObjects: Binding<NSSet?>, selectedObjectsEntityType: EntityType, toManyFilterType: ToManyFilterType, inverseRelationshipName: String) {
        self.parentCustomUUID = parentCustomUUID
        _selectedObjects = selectedObjects
        self.selectedObjectsEntityType = selectedObjectsEntityType
        self.toManyFilterType = toManyFilterType
        _placeholderDetailsContainer = StateObject(wrappedValue: ObjectPlaceholderDetailsContainer(parentCustomUUID, toManyFilterType))
        self.relationshipName = inverseRelationshipName
    }
    
    @EnvironmentObject var ads: AppDataStore
    
    @EnvironmentObject var vem: ViewEditingManager
    
    @Environment(\.dismiss) private var dismiss
    
    
    let parentCustomUUID: String
    
    @Binding var selectedObjects: NSSet?
    
    let selectedObjectsEntityType: EntityType
    
    // TODO: Have this kind of data as an extension in EntityExtensions ??
    let toManyFilterType: ToManyFilterType
    
    
    @StateObject var placeholderDetailsContainer: ObjectPlaceholderDetailsContainer
    
    let relationshipName: String
    
    
    // MARK: - General
    
    @Environment(\.managedObjectContext) var moc
    
    var fetcher: CoreDataFetcher { CoreDataFetcher(moc) }
    
    func setUpView() {
        print("ToManyListParentView moc: \(moc)")
        print("ToManyListParentView fetcher.context: \(fetcher.context)")
        let objects = fetcher.fetchAllObjects(selectedObjectsEntityType)
        if objects.isEmpty {
            nilObjects = true
        }
        placeholderDetailsContainer.loadContainer(objects, relationshipName)
        
    }
    
    @State private var nilObjects = false
    
    
    func setObjectNSSet() {
        switch toManyFilterType {
        case .oneToMany:
            saveOneToMany()
        case .manyToMany:
            saveManyToMany()
        }
    }
    
    
    func saveOneToMany() {
        let customUUIDs = placeholderDetailsContainer.selectedPlaceholderDetails.returnCustomUUIDsFromObjectPlaceholders()
        let objects = fetcher.returnAllObjectsFromAllCustomUUIDs(customUUIDs)
        selectedObjects = objects.asNSSet()
    }
    
    func saveManyToMany() {
        let customUUIDs = placeholderDetailsContainer.returnCustomUUIDsFromToggledPlaceholderDetails()
        let objects = fetcher.returnAllObjectsFromAllCustomUUIDs(customUUIDs)
        selectedObjects = objects.asNSSet()
    }
    
    
    var saveButton: CustomButton { CustomButton("Confirm", OptionalFunc(saveFunc)) }
    var cancelButton: CustomButton { CustomButton(.cancel, OptionalFunc(cancelFunc)) }
    
    
    func saveFunc() {
        setObjectNSSet()
        ads.refresh()
        dismiss()
    }
    
    func cancelFunc() {
        // TODO: This doesn't let me use the DiscardChanges Alert inside an EditXObjectDetail View
        dismiss()
    }
    
    
    var body: some View {
        
        List {
            
            switch toManyFilterType {
            case .oneToMany:
                OneToManyListView(placeholderDetailsContainer: placeholderDetailsContainer)
            case .manyToMany:
                ManyToManyListView(placeholderDetailsContainer: placeholderDetailsContainer)
            }
            
        }
        
        
        
        
        
        // TODO: Issue with saving the ToManyListParentView, as it is trying to save objects from ADS (the main context), to a the new object in the child Context
        .standardGenericEditViewModifiers(vem, saveButton, cancelButton)
        
        .navigationTitle("Add \(selectedObjectsEntityType.pluralRawValue())")
        
        .onAppear() {
            setUpView()
        }
        
        
        .onChange(of: vem.editMode) {
            dismiss()
        }
        
        
        .overlay {
            if nilObjects {
                ContentUnavailableView {
                    Label("No \(selectedObjectsEntityType.pluralRawValue().lowercased()) found", systemImage: "tray.fill")
                } description: {
                    Text("You need to create some \(selectedObjectsEntityType.pluralRawValue().lowercased()) before you can assign them")
                }
                                
            }
        }
        
        
        
    }
}


#Preview {
    
    let parentObject = CoreDataPreviewManager.fetchPreviewObject(.category).castedAsCategory()
    
    let vem = ViewEditingManager(CoreDataManager.preview.container.viewContext)
    vem.editMode = .active
    
    let previewView = NavigationStack {
        ToManyListParentView(
            object: parentObject,
            selectedObjects: .createBinding(parentObject.items),
            toManyFilterType: .manyToMany,
            relationshipName: .items
        )
    }
    
        .environmentObject(AppDataStore(CoreDataManager.preview.container.viewContext))
        .environmentObject(vem)
    
    
    return previewView
    
}

