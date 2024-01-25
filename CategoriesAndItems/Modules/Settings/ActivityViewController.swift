//
//  ActivityViewController.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation
import SwiftUI


struct ActivityViewController: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityView = UIActivityViewController(activityItems: [], applicationActivities: nil)
        return activityView
        
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
    func initView() {

        let avc = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)

        UIApplication.shared.currentUIWindow()?.rootViewController?.present(avc, animated: true, completion: nil)
        
    }
    
    
}



