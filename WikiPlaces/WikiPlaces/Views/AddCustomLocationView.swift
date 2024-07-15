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
        guard let latitude = Double(lat), let longitude = Double(long) else {
            alertMessage = "Please enter valid numbers for latitude and longitude."
            showAlert = true
            return
        }

        guard latitude >= -90 && latitude <= 90 else {
            alertMessage = "Latitude must be between -90 and 90 degrees."
            showAlert = true
            return
        }

        guard longitude >= -180 && longitude <= 180 else {
            alertMessage = "Longitude must be between -180 and 180 degrees."
            showAlert = true
            return
        }

        let newLocation = Location(name: name, lat: latitude, long: longitude)
        viewModel.addLocation(newLocation)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    ContentView(viewModel: LocationViewModel())
}
