//
//  ContentView.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LocationViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.locations) { location in
                Button(action: {
                    viewModel.openLocation(location)
                }) {
                    HStack {
                        Text(location.displayName)
                        Spacer()
                        Image(systemName: "chevron.compact.right")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Locations")
            .onAppear {
                viewModel.fetchLocations()
            }
            .alert(isPresented: .constant(viewModel.error != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
