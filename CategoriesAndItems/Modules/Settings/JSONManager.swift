//
//  JSONManager.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import CoreData


struct JSONManager {
    
    
    
    func writeEntityObjectsToURL<T: Encodable>(_ objects: [T]) -> URL {
        
        let fileName: String = String(describing: "All\(T.self)Objects")
        
        let fileURL = returnURLFromFileName(fileName)
        
        let jsonString = convertObjectsToJSONString(objects)
        
        writeJSONStringToURL(jsonString, fileURL)
        
        return fileURL
        
    }
    
    
    
    private func writeJSONStringToURL(_ jsonString: String, _ fileURL: URL) {
        do {
            try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Could not write jsonString to URL")
        }
    }
    
    
    
    
    // MARK: - Document Directory
    
    private func returnURLFromFileName(_ fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    
    private func returnURLFromFileName(_ fileName: String,_ fileType: String) -> URL? {
        return Bundle.main.url(forResource: fileName, withExtension: fileType)
    }
    
    
    
    private func convertObjectsToJSONString<T: Encodable>(_ objects: [T]) -> String {
        do {
            let jsonData = try JSONEncoder().encode(objects)
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    
    
    // MARK: - Load objects from URL
    
    
    func returnObjectsFromURL<T: Decodable>(_ url: URL) -> [T] {
        var decodedObjects: [T] = []
        do {
            let jsonData = returnDataFromURL(url)
            decodedObjects = try JSONDecoder().decode([T].self, from: jsonData)
            return decodedObjects
        } catch {
            print(error.localizedDescription)
            print("could not load objects from url")
            
        }
        return decodedObjects
    }
    

    
     private func returnDataFromURL(_ url: URL) -> Data {
        do {
            let jsonData = try Data(contentsOf: url)
            return jsonData
        } catch {
            print("the url could not be converted to data")
            print(error.localizedDescription)
            // TODO: don't like this return, should it be an optional ?
            return Data()
        }
    }
    
    
}


extension CodingUserInfoKey {
       static let context = CodingUserInfoKey(rawValue: "context")
    }

