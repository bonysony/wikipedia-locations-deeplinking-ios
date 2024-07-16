//
//  ErrorStateView.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 15/07/2024.
//

import Foundation
import SwiftUI

// MARK: - ErrorStateView

struct ErrorStateView: View {
    var error: WPError.NetworkError
    var retryAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "network.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)

            Text(error.errorDescription)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding()

            Button(action: retryAction) {
                Text(NSLocalizedString("error-state.try_again_button", comment: ""))
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(40)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

// MARK: - ErrorStateView_Previews

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(error: WPError.NetworkError.unreachable, retryAction: {})
    }
}
