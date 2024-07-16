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
                Section {
                    TextField(NSLocalizedString("locations-add.form.name", comment: ""), text: $name)
                    TextField(NSLocalizedString("locations-add.form.latitude", comment: ""), text: $lat)
                        .keyboardType(.decimalPad)
                        .onChange(of: lat) {
                            lat = lat.filter { "0123456789.-".contains($0) }
                        }
                    TextField(NSLocalizedString("locations-add.form.longitude", comment: ""), text: $long)
                        .keyboardType(.decimalPad)
                        .onChange(of: long) {
                            long = long.filter { "0123456789.-".contains($0) }
                        }
                }
                Button(action: addLocation) {
                    Text(NSLocalizedString("locations-add.form.add_location_button", comment: ""))
                }
            }
            .navigationTitle(NSLocalizedString("locations-add.navigation_title", comment: ""))
            .navigationBarItems(leading: Button(NSLocalizedString("locations-add.navigation_cancel_button", comment: "")) {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text(NSLocalizedString("locations-add.alert.invalid_input.title", comment: "")), message: Text(alertMessage), dismissButton: .default(Text(NSLocalizedString("locations-add.alert.ok_button", comment: ""))))
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
            alertMessage = NSLocalizedString("locations-add.alert.unexpected_error.message", comment: "")
            showAlert = true
        }
    }
}

#Preview {
    ContentView(viewModel: LocationViewModel(locationService: MockLocationService(), coordinator: MockCoordinator()))
}
