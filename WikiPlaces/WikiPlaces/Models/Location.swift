//
//  Location.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import Foundation

struct Location: Identifiable, Codable {
    let name: String?
    let lat: Double
    let long: Double
    
    var id: UUID {
        return UUID()
    }
    
    // Computed property to provide a default name
    var displayName: String {
        return name ?? "Custom Location"
    }
}

struct LocationResponse: Codable {
    let locations: [Location]
}
