//
//  LocationViewModel.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//
import Foundation
import SwiftUI

enum ViewStatus {
    case initialised
    case loading
    case loaded
    case error
}

class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var viewStatus: ViewStatus = .initialised
    @Published var error: Error?

    private let locationService: LocationServiceProtocol
    private let coordinator: Coordinator

    init(locationService: LocationServiceProtocol, coordinator: Coordinator) {
        self.locationService = locationService
        self.coordinator = coordinator
    }

    @MainActor
    func loadLocations() async {
        viewStatus = .loading
        do {
            let fetchedLocations = try await locationService.fetchLocations()
            locations = fetchedLocations
            viewStatus = .loaded
        } catch {
            self.error = WPError.LocationServiceError.fetchFailed(error)
            viewStatus = .error
        }
    }

    @MainActor
    func addCustomLocation(location: Location) {
        var newLocation = location
        newLocation.isCustom = true
        locations.append(newLocation)
    }

    func openLocation(_ location: Location) async {
        do {
            if let url = coordinator.createURL(from: location) {
                try await coordinator.openURL(url)
            }
        } catch {
            self.error = WPError.CoordinatorError.cannotOpenURL
            viewStatus = .error
        }
    }

    func validateLatitude(_ lat: String) throws -> Double {
        guard let latitude = Double(lat) else {
            throw WPError.ValidationError.invalidNumbers
        }
        guard latitude >= -90 && latitude <= 90 else {
            throw WPError.ValidationError.latitudeOutOfBounds
        }
        return latitude
    }

    func validateLongitude(_ long: String) throws -> Double {
        guard let longitude = Double(long) else {
            throw WPError.ValidationError.invalidNumbers
        }
        guard longitude >= -180 && longitude <= 180 else {
            throw WPError.ValidationError.longitudeOutOfBounds
        }
        return longitude
    }
}
