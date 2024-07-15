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
        return name ?? "Unnamed Location"
    }
    
    var isCustom: Bool = false
    
    private enum CodingKeys : String, CodingKey {
        case name, lat, long
    }
}

struct LocationResponse: Codable {
    let locations: [Location]
}
