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

@MainActor
class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var viewStatus: ViewStatus = .initialised
    @Published var errorMessage: String?

    private let locationService: LocationServiceProtocol
    private let coordinator: Coordinator

    init(locationService: LocationServiceProtocol, coordinator: Coordinator) {
        self.locationService = locationService
        self.coordinator = coordinator
        Task {
            await fetchLocations()
        }
    }

    func fetchLocations() async {
        viewStatus = .loading
        do {
            let fetchedLocations = try await locationService.fetchLocations()
            locations = fetchedLocations
            viewStatus = .loaded
        } catch {
            errorMessage = "Failed to fetch locations. Please check your network connection."
            viewStatus = .error
        }
    }

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
            errorMessage = "Could not open uRL"
            viewStatus = .error
        }
        
        
    }
}
