//
//  ViewModifiers.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import SwiftUI
import CoreData



// MARK: - GENERIC !!!

extension View {
    
    func standardGenericEditViewModifiers(_ vem: ViewEditingManager, _ saveButton: CustomButton, _ cancelButton: CustomButton, _ df: OptionalFunc = .blank) -> some View {
        modifier(StandardGenericEditViewModifiers(vem: vem, saveButton: saveButton, cancelButton: cancelButton, df: df))
    }
    
}



struct StandardGenericEditViewModifiers: ViewModifier {
    @ObservedObject var vem: ViewEditingManager
    
    let saveButton: CustomButton
    let cancelButton: CustomButton
    
    var df: OptionalFunc
    
    func body(content: Content) -> some View {
        
        content
        
            .genericEditToolbar(vem, saveButton, cancelButton)
        
            .ifEditBackButton(vem)
        
            .genericDiscardChangesAlert(vem, df)
        
        
    }
    
}


// MARK: GenericEditToolBar

extension View {
    
    fileprivate func genericEditToolbar(_ vem: ViewEditingManager, _ saveButton: CustomButton, _ cancelButton: CustomButton) -> some View {
        modifier(GenericEditToolBar(vem: vem, saveButton: saveButton, cancelButton: cancelButton))
    }
    
}


struct GenericEditToolBar: ViewModifier {
    
    @ObservedObject var vem: ViewEditingManager
    
    let saveButton: CustomButton
    let cancelButton: CustomButton
    
    func body(content: Content) -> some View {
        
        content
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    if vem.editMode == .inactive {
                        Button("Edit") {
                            vem.activeEditMode()
                        }
                    } else if vem.editMode == .active {
                        saveButton
                    }
                }
                
                if vem.editMode == .active {
                    ToolbarItem(placement: .topBarLeading) {
                        cancelButton
                    }
                }
                
                
                
            }
        
        
    }
    
}



extension View {
    
    fileprivate func genericDiscardChangesAlert(_ vem: ViewEditingManager, _ df: OptionalFunc = .blank) -> some View {
        modifier(GenericDiscardChangesAlert(vem: vem, df: df))
    }
    
}



struct GenericDiscardChangesAlert: ViewModifier {
    @ObservedObject var vem: ViewEditingManager
    var df: OptionalFunc
    func body(content: Content) -> some View {
        content
            .alert("Discard Changes", isPresented: $vem.cancelChanges) {
                Button("Discard", role: .destructive) {
                    df.call()
                }
                Button("Return", role: .cancel) { }
            } message: {
                Text("Are you sure you want to discard your recent changes? ")
            }
        
        
    }
    
}




// MARK: - If Editing Navigation Back Button

extension View {
    //    fileprivate
    func ifEditBackButton(_ vem: ViewEditingManager) -> some View {
        modifier(IfEditBackButton(vem: vem))
        
    }
    
}


struct IfEditBackButton: ViewModifier {
    @ObservedObject var vem: ViewEditingManager
    func body(content: Content) -> some View {
        
        content
            .navigationBarBackButtonHidden(vem.backButton)
        
            .onChange(of: vem.editMode) {
                vem.toggleBackButton()
            }
        
    }
    
}


// MARK: - Discard Changes Alert

extension View {
    
    fileprivate func discardChangesAlert(_ vem: ViewEditingManager, _ of: OptionalFunc = .blank) -> some View {
        modifier(DiscardChangesAlert(vem: vem, of: of))
        
    }
    
}



struct DiscardChangesAlert: ViewModifier {
    @ObservedObject var vem: ViewEditingManager
    var of: OptionalFunc
    func body(content: Content) -> some View {
        content
            .alert("Discard Changes", isPresented: $vem.cancelChanges) {
                Button("Discard", role: .destructive) {
                    vem.discardChanges()
                    of.call()
                }
                Button("Return", role: .cancel) { }
            } message: {
                Text("Are you sure you want to discard your recent changes? ")
            }
        
        
    }
    
}




// MARK: - Delete Object Alert

extension View {
    
    func deleteObjectAlert(_ object: NSManagedObject , _ vem: ViewEditingManager, _ ads: AppDataStore, _ dismissView: DismissAction? = nil) -> some View {
        modifier(DeleteObjectAlert(object: object, vem: vem, ads: ads, dismissView: dismissView))
    }
    
}



struct DeleteObjectAlert: ViewModifier {
    @ObservedObject var object: NSManagedObject
    @ObservedObject var vem: ViewEditingManager
    @ObservedObject var ads: AppDataStore
    
    var dismissView: DismissAction?
    
    func deleteObject() {
        if let dismissView {
            dismissView()
        }
        vem.deleteObject(object)
        ads.refresh()
    }
    
    func body(content: Content) -> some View {
        content
        // TODO: FORCE UNWRAP
            .alert("Delete \(object.entityType()!.rawValue)", isPresented: $vem.forDelete) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deleteObject()
                }
            } message: {
                // TODO: FORCE UNWRAP
                Text("Are you sure you want to delete this \(object.entityType()!.rawValue.lowercased())?")
            }
        
    }
    
}


// MARK: - Generic Delete Object Button

struct GenericDeleteObjectButton: View {
    
    init(_ object: NSManagedObject, _ dismissView: DismissAction) {
        self.object = object
        self.dismissView = dismissView
    }
    
    @ObservedObject var object: NSManagedObject
    @EnvironmentObject var vem: ViewEditingManager
    @EnvironmentObject var ads: AppDataStore
    
    var dismissView: DismissAction
    
    var body: some View {
        if vem.editMode == .active {
            Section {
                Button {
                    vem.forDelete.toggle()
                } label: {
                    HStack {
                        Spacer()
                        // TODO: FORCE UNWRAP
                        Text("Delete \(object.entityType()!.rawValue)")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            
            .deleteObjectAlert(object, vem, ads, dismissView)
            
        }
        
    }
}
