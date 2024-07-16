//
//  AddCustomLocationView.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 14/07/2024.
//

import Foundation
import SwiftUI

struct AddCustomLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LocationViewModel
    @State private var name: String = ""
    @State private var lat: String = ""
    @State private var long: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Location")) {
                    TextField("Name", text: $name)
                    TextField("Latitude", text: $lat)
                        .keyboardType(.decimalPad)
                        .onChange(of: lat) {
                            lat = lat.filter { "0123456789.-".contains($0) }
                        }
                    TextField("Longitude", text: $long)
                        .keyboardType(.decimalPad)
                        .onChange(of: long) {
                            long = long.filter { "0123456789.-".contains($0) }
                        }
                }
                Button(action: addLocation) {
                    Text("Add Location")
                }
            }
            .navigationTitle("Add Location")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func addLocation() {
        do {
            let latitude = try viewModel.validateLatitude(lat)
            let longitude = try viewModel.validateLongitude(long)
            let newLocation = Location(name: name, lat: latitude, long: longitude)
            viewModel.addCustomLocation(location: newLocation)
            presentationMode.wrappedValue.dismiss()
        } catch let error as WPError.ValidationError {
            alertMessage = error.errorDescription
            showAlert = true
        } catch {
            alertMessage = "An unexpected error occurred."
            showAlert = true
        }
    }
}

#Preview {
    ContentView(viewModel: LocationViewModel(locationService: MockLocationService(), coordinator: MockCoordinator()))
}
