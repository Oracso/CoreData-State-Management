//
//  DataDownloadView.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI
import CoreData

// Process

// Objects -> JSON

//  - The CoreData objects need to be parsed into JSON
//  - The JSON string needs to be saved to a file somewhere in the app directory (I'm not sure if this is saved unless specified?)
//  - The file is then accessed and saved to the User's personal documents

// JSON -> Objects

// - The JSON file is then accessed via its URL
// - URL is used to create the CoreData objects


struct DataDownloadView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    
    @StateObject var dDManager = DataDownloadManager(CoreDataManager.shared.container.viewContext)
    
    @StateObject var entityTracker = EntitySelectionTracker()
    
    
    func resetToggleSelections() {
        entityTracker.createSelections()
    }

    
    
    func writeObjectsToJSON() {
        for entity in entityTracker.entities {
            if entity.selected {
                let objects = dDManager.fetcher.fetchAllObjects(entity.entity)
                
                // TODO: FORCE UNWRAP
                switch entity.entity {
                case .category:
                    let castedObjects = objects as! [Category]
                    dDManager.writeObjectsAndAddURLToArray(castedObjects)
                case .item:
                    let castedObjects = objects as! [Item]
                    dDManager.writeObjectsAndAddURLToArray(castedObjects)
                }
                
            }
        }
        
   
        
        
        // MARK: - Random Function ...? (Useful)
        func inOutType(type: Any.Type) -> Any.Type {
            return type
        }
        
        
    }
    
    
    func downloadFiles() {
        writeObjectsToJSON()
        ActivityViewController(activityItems: dDManager.finalURLs).initView()
        resetToggleSelections()
    }
    
    
    func entityRowDisplay(_ entityName: String, _ quantity: Int) -> String {
        return "\(entityName) (Q: \(quantity))"
    }
    
    
    
    
    
    var body: some View {
        
        
        List {
            
            
            
            Section("Entities") {
                ForEach($entityTracker.entities) { entity in
                    Toggle(entityRowDisplay(entity.wrappedValue.entity.rawValue, dDManager.fetcher.fetchAllObjects(entity.id).count), isOn: entity.selected)
                }
                
            }
            
            
            
            Button("Download Files") {
                downloadFiles()
            }
            
            
        }
        
        
        .navigationTitle("Download Data")
        
        
        .onAppear() {
            resetToggleSelections()
        }
        
        
    }
}

#Preview {
    NavigationStack {
        DataDownloadView()
            .environment(\.managedObjectContext, CoreDataManager.preview.container.viewContext)
    }
}





