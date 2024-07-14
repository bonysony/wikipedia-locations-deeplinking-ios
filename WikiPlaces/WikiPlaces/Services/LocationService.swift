//
//  LocationService.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//
import Foundation

protocol LocationServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

class LocationService: LocationServiceProtocol {
    func fetchLocations() async throws -> [Location] {
        guard let url = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("JSON Data: \(jsonString)")
        }
        
        let decoder = JSONDecoder()
        
        do {
            let locationResponse = try decoder.decode(LocationResponse.self, from: data)
            return locationResponse.locations
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
}
