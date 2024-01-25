//
//  CustomButton.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let optionalFunc: OptionalFunc
    var body: some View {
        Button(text) {
            optionalFunc.call()
        }
    }
}

extension CustomButton {
    init(_ text: String, _ optionalFunc: OptionalFunc) {
        self.text = text
        self.optionalFunc = optionalFunc
    }
    
    init(_ textType: TextType, _ optionalFunc: OptionalFunc) {
        self.text = textType.rawValue
        self.optionalFunc = optionalFunc
    }
    
    enum TextType: String {
        case save = "Save"
        case cancel = "Cancel"
        case edit = "Edit"
    }
    
}
