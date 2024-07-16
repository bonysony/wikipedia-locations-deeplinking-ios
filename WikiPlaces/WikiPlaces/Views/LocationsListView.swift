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
                            Text("Lat:")
                                .font(.body)
                            Text("\(location.lat)")
                                .truncationMode(.tail)
                                .lineLimit(0)
                                .font(.body)
                        }
                        HStack {
                            Text("Long:")
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
        .navigationTitle("Locations")
        .navigationBarItems(trailing: HStack {
            Button(action: {
                showAddLocationSheet = true
            }) {
                Image(systemName: "plus.circle.fill")
            }
        })
        .alert(isPresented: .constant(viewModel.error != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
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
