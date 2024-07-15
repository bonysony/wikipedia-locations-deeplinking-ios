//
//  ErrorStateView.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 15/07/2024.
//

import Foundation

import SwiftUI

struct ErrorStateView: View {
    var errorMessage: String
    var retryAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Text("Oops!")
                .font(.title)
                .fontWeight(.bold)
            
            Text(errorMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: retryAction) {
                Text("Try Again")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(errorMessage: "We couldn't load your data. Please check your connection and try again.", retryAction: {})
    }
}
