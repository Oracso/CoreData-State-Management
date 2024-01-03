//
//  ObjectPlaceholderDetailsContainer.swift
//  CategoriesAndItems
//
//  Created by Oscar Hardy on 03/01/2024.
//

import Foundation

class ObjectPlaceholderDetailsContainer: ObservableObject {
    
    
    init(_ parentCustomUUID: String , _ toManyFilterType: ToManyFilterType) {
        
        self.parentCustomUUID = parentCustomUUID
        self.toManyFilterType = toManyFilterType
        
    }
    
    
    let odpm = ObjectPlaceholderDetailsManager()
    
    let parentCustomUUID: String
    
    let toManyFilterType: ToManyFilterType
    
    
    
    
    func loadContainer( _ objects: [NSManagedObject], _ relationshipName: String) {
        
        let placeholderDetails = odpm.createAllEntityObjectPlaceholderDetails(objects)
        
        switch toManyFilterType {
        case .oneToMany:
            filterAndAssignPlaceholderDetailsToArrays(placeholderDetails, relationshipName)
        case .manyToMany:
            loadPlaceholderToggles(placeholderDetails, relationshipName)
        }
    }
    

    // MARK: For OneToMany
    
    @Published var selectedPlaceholderDetails: [ObjectPlaceholderDetails] = []
    
    @Published var unassignedPlaceholderDetails: [ObjectPlaceholderDetails] = []
    
    @Published var assignedPlaceholderDetails: [ObjectPlaceholderDetails] = []
    
    
    // MARK: For ManyToMany
    
    
    @Published var allObjectPlaceholderDetailsToggles: [ObjectPlaceholderDetailsToggle] = []
    
    
}




extension ObjectPlaceholderDetailsContainer {
    
    // MARK: For OneToMany
    
    func filterAndAssignPlaceholderDetailsToArrays( _ placeholderDetails: [ObjectPlaceholderDetails], _ relationshipName: String) {
        let filtered = odpm.filterPlaceholderDetailsByUnassignedAssignedAndSelf(toManyFilterType, placeholderDetails, parentCustomUUID, relationshipName)
        selectedPlaceholderDetails = filtered.assignedToSelf
        unassignedPlaceholderDetails = filtered.unassigned
        assignedPlaceholderDetails = filtered.assigned
    }
    
    
    // MARK: For ManyToMany
    
    
    func loadPlaceholderToggles( _ placeholderDetails: [ObjectPlaceholderDetails], _ relationshipName: String) {
        allObjectPlaceholderDetailsToggles = createAllObjectPlaceholderDetailsToggle(placeholderDetails, relationshipName)
    }
    
    
}




extension ObjectPlaceholderDetailsContainer {
    
    func createObjectPlaceholderDetailsToggle(_ placeholderDetails: ObjectPlaceholderDetails,  _ relationshipName: String) -> ObjectPlaceholderDetailsToggle {
        var selected: Bool {
            //            placeholderDetails.checkForToManyRelationship(parentCustomUUID, relationshipName)
            placeholderDetails.checkForAnyRelationship(parentCustomUUID, relationshipName)
        }
        return ObjectPlaceholderDetailsToggle(toggle: selected, placeholderDetails: placeholderDetails)
    }
    
    func createAllObjectPlaceholderDetailsToggle(_ allPlaceholderDetails: [ObjectPlaceholderDetails],  _ relationshipName: String) -> [ObjectPlaceholderDetailsToggle] {
        var array: [ObjectPlaceholderDetailsToggle] = []
        for placeholderDetails in allPlaceholderDetails {
            array.append(createObjectPlaceholderDetailsToggle(placeholderDetails, relationshipName))
        }
        return array
    }
    
}


extension ObjectPlaceholderDetailsContainer {
    
    func returnCustomUUIDsFromToggledPlaceholderDetails() -> [String] {
        let toggled = allObjectPlaceholderDetailsToggles.filter({$0.toggle == true})
        let allPlaceholderDetails = toggled.map { $0.placeholderDetails }
        let customUUIDs = allPlaceholderDetails.map { $0.customUUID }
        return customUUIDs
    }
    
}

