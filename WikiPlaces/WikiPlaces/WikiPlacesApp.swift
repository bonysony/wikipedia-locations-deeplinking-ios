//
//  WikiPlacesApp.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import SwiftUI

@main
struct WikiPlacesApp: App {
    var body: some Scene {
        WindowGroup {
            let service = LocationService()
            let useCase = FetchLocationsUseCase(locationService: service)
            let coordinator = AppCoordinator()
            let viewModel = LocationViewModel(locationUseCase: useCase, coordinator: coordinator)
            ContentView(viewModel: viewModel)
        }
    }
}
