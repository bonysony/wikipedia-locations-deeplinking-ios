//
//  LocationViewModel.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//
import Foundation
import SwiftUI

@MainActor
class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var error: String?

    private let locationUseCase: LocationUseCaseProtocol
    private let coordinator: Coordinator

    init(locationUseCase: LocationUseCaseProtocol = FetchLocationsUseCase(locationService: LocationService()),
         coordinator: Coordinator = AppCoordinator()) {
        self.locationUseCase = locationUseCase
        self.coordinator = coordinator
        fetchLocations()
    }

    func fetchLocations() {
        Task {
            do {
                let locations = try await locationUseCase.fetchLocations()
                self.locations = locations
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    func openLocation(_ location: Location) {
        coordinator.openLocation(location)
    }
}
