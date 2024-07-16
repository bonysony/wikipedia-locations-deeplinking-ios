//
//  LocationsListView.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import SwiftUI

struct LocationsListView: View {
    @ObservedObject var viewModel: LocationViewModel
    @State private var showAddLocationSheet = false

    var body: some View {
        List(viewModel.locations) { location in
            Button(action: {
                Task {
                    await viewModel.openLocation(location)
                }
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(location.displayName)
                            .font(.title2)
                            .bold()
                        HStack {
                            Text(NSLocalizedString("locations-list.latitude_label", comment: ""))
                                .font(.body)
                            Text("\(location.lat)")
                                .truncationMode(.tail)
                                .lineLimit(0)
                                .font(.body)
                        }
                        HStack {
                            Text(NSLocalizedString("locations-list.longitude_label", comment: ""))
                                .font(.body)
                            Text("\(location.long)")
                                .font(.body)
                                .truncationMode(.tail)
                                .lineLimit(0)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .contentShape(Rectangle())
        }
        .navigationTitle(NSLocalizedString("locations-list.navigation_title", comment: ""))
        .navigationBarItems(trailing: HStack {
            Button(action: {
                showAddLocationSheet = true
            }) {
                Image(systemName: "plus.circle.fill")
            }
        })
        .alert(isPresented: .constant(viewModel.error != nil)) {
            Alert(
                title: Text(NSLocalizedString("locations-list.error_title", comment: "")),
                message: Text(viewModel.error?.localizedDescription ?? NSLocalizedString("locations-list.unknown_error", comment: "")),
                dismissButton: .default(Text(NSLocalizedString("locations-list.ok_button", comment: "")))
            )
        }
        .background(Color(UIColor.systemGray6))
        .sheet(isPresented: $showAddLocationSheet) {
            AddCustomLocationView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView(viewModel: LocationViewModel(locationService: MockLocationService(), coordinator: MockCoordinator()))
}
