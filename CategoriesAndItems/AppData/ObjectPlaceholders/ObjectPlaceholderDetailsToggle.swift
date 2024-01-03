//
//  ObjectPlaceholderDetailsToggle.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation


class ObjectPlaceholderDetailsToggle: Identifiable {
    
    internal init(toggle: Bool, placeholderDetails: ObjectPlaceholderDetails) {
        self.toggle = toggle
        self.placeholderDetails = placeholderDetails
    }
    
    @Published var toggle: Bool
    
    let placeholderDetails: ObjectPlaceholderDetails
    
    var id: String { placeholderDetails.customUUID }
    
}
