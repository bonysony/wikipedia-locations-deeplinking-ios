//
//  FetchLocationsUseCase.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import Foundation

protocol LocationUseCaseProtocol {
    func fetchLocations() async throws -> [Location]
}

class FetchLocationsUseCase: LocationUseCaseProtocol {
    private let locationService: LocationServiceProtocol

    init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
    }

    func fetchLocations() async throws -> [Location] {
        return try await locationService.fetchLocations()
    }
}
