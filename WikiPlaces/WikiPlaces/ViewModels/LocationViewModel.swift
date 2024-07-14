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

    init(locationUseCase: LocationUseCaseProtocol = FetchLocationsUseCase(locationService: LocationService())) {
        self.locationUseCase = locationUseCase
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
}
