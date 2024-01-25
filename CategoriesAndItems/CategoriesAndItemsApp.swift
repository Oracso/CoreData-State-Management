//
//  CategoriesAndItemsApp.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

@main
struct CategoriesAndItemsApp: App {
    
    init() {
        print("Not first launch")
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "hasLaunched") == true {
            
        } else {
            print("First Launch")
            defaults.set(true, forKey: "hasLaunched")
        }
    }
    
    let coreDataManager = CoreDataManager.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var appDataStore = AppDataStore(CoreDataManager.shared.container.viewContext)
    
    @StateObject var viewEditingManager = ViewEditingManager(CoreDataManager.shared.container.viewContext)
    
    let previewManager = CoreDataPreviewManager(CoreDataManager.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            
            TabBarView()
            
                .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
            
                .environmentObject(appDataStore)
            
                .environmentObject(viewEditingManager)
            
        }
        
        .onChange(of: scenePhase) { phase, _ in
            switch phase {
            case .background:
                print("background")
            case .inactive:
                print("scene phase -> inactive")
            case .active:
                print("scene phase -> active")
            @unknown default:
                print("scene phase -> unknown - update switch statement")
            }
        }
        
        
    }
}
