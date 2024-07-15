//
//  ContentView.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: LocationViewModel
    @State private var showAddLocationSheet = false

    var body: some View {
        NavigationView {
            List(viewModel.locations) { location in
                Button(action: {
                    viewModel.openLocation(location)
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(location.displayName)
                                .bold()
                            HStack {
                                Text("Lat:").bold()
                                Text("\(location.lat)")
                                Text("Long:").bold()
                                Text("\(location.long)")
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Locations")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    showAddLocationSheet = true
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    viewModel.fetchLocations()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            })
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
            .background(Color(UIColor.systemGray6))
        }
        .sheet(isPresented: $showAddLocationSheet) {
            AddLocationView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView(viewModel: LocationViewModel())
}
