//
//  LocationService.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//
import Foundation

// MARK: - LocationServiceProtocol

protocol LocationServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

// MARK: - LocationService

class LocationService: LocationServiceProtocol {
    let locationsDataURL = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchLocations() async throws -> [Location] {
        guard let url = URL(string: locationsDataURL) else {
            throw WPError.LocationServiceError.invalidURL
        }

        let (data, _) = try await session.data(from: url)

        if let jsonString = String(data: data, encoding: .utf8) {
            print("JSON Data: \(jsonString)")
        }

        let decoder = JSONDecoder()

        do {
            let locationResponse = try decoder.decode(LocationResponse.self, from: data)
            return locationResponse.locations
        } catch {
            throw WPError.LocationServiceError.decodingFailed(error)
        }
    }
}

// MARK: - MockLocationService

struct MockLocationService: LocationServiceProtocol {
    let location = Location(name: "Foo", lat: 57.282828, long: 24.3423423)
    func fetchLocations() async throws -> [Location] {
        return [location]
    }
}
