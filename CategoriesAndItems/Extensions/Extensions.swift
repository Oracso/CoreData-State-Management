//
//  Extensions.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import SwiftUI

extension Binding {
    
    /// Ensure default Type is correct -- Otherwise will crash
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }

}


// MARK: - Create Binding

extension Binding {
    static func createBinding(_ value: Value) -> Binding<Value> {
        var bindingValue = value
        return Binding(
            get: { bindingValue },
            set: { newValue in
                bindingValue = newValue
            }
        )
    }
}


extension Date {

    static func yearsDif(_ years: Int) -> Date {
        let seconds = Double(31536000 * years)
        return Date.now.addingTimeInterval(seconds)
    }
    
    static func daysDif(_ days: Int) -> Date {
        let seconds = Double(86400 * days)
        return Date.now.addingTimeInterval(seconds)
    }
    
    static func hoursDif(_ hours: Int) -> Date {
        let seconds = Double(3600 * hours)
        return Date.now.addingTimeInterval(seconds)
    }
    
}


extension URL {
    static let example = URL(string: "ExampleURL")
    
}


public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }
        return window
    }
}




// TODO: How to add this and make it work?
//UINavigationController NavigationStack
//extension NavigationStack {
//    public func settingsToolbar(_ self: Self) -> some View {
//        self.toolbar {
//            
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink {
//                    SettingsView()
//                } label: {
//                    Image(systemName: "person.circle")
//                }
//            }
//            
//        }
//    }
//}


extension String {
    func insertSpacesBeforeUppercaseLetters() -> String {
        let pattern = "(?<=\\p{Ll})(?=\\p{Lu})"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.utf16.count)
        
        let modifiedString = regex.stringByReplacingMatches(
            in: self,
            options: [],
            range: range,
            withTemplate: " "
        )
        
        return modifiedString
    }
}



