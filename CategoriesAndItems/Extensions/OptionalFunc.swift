//
//  OptionalFunc.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation


struct OptionalFunc {
    
    init(_ call: Func? = nil) {
        if let call {
            self.call = call
        } else {
            self.call = {}
        }
        
    }
    
    typealias Func = () -> Void
    
    var call: Func
    
    
    
}

extension OptionalFunc {
    static let blank = OptionalFunc()
}
