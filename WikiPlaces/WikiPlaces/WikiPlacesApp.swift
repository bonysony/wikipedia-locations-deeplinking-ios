//
//  WikiPlacesApp.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import SwiftUI

@main
struct WikiPlacesApp: App {
    @StateObject private var viewModel: LocationViewModel
    private var coordinator: AppCoordinator

    init() {
        let service = LocationService()
        let useCase = FetchLocationsUseCase(locationService: service)
        let coordinator = AppCoordinator()
        let viewModel = LocationViewModel(locationUseCase: useCase)
        
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environmentObject(coordinator)
        }
    }
}
