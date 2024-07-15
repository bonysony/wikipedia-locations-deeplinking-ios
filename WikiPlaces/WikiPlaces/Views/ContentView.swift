//
//  ContentView.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: LocationViewModel

    var body: some View {
        NavigationView {
            switch viewModel.viewStatus {
            case .initialised, .loading:
                ProgressView("Loading...")
            case .loaded:
                LocationsListView(viewModel: viewModel)
            case .error:
                ErrorStateView(errorMessage: "Failed to load locations.", retryAction: {
                    Task {
                        await viewModel.fetchLocations()
                    }
                })
            }
        }
    }
}
