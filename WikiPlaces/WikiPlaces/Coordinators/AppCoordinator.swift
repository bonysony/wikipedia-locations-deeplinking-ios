//
//  AppCoordinator.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import Foundation
import SwiftUI

protocol Coordinator {
    func openURL(_ url: URL) async throws
    func createURL(from location: Location) -> URL?
}

enum CoordinatorError: Error {
    case cannotOpenURL
    case unsupportedURLScheme

    var description: String {
        switch self {
        case .cannotOpenURL:
            return "Failed to open URL. Please check the format."
        case .unsupportedURLScheme:
            return "This URL scheme is not supported. Please check if the Wikipedia app is installed."
        }
    }
}

class AppCoordinator: Coordinator, ObservableObject {
    
    @MainActor
    func openURL(_ url: URL) async throws {
        print("Attempting to open URL: \(url.absoluteString)")
    
        if UIApplication.shared.canOpenURL(url) {
            await UIApplication.shared.open(url)
        } else {
            throw CoordinatorError.unsupportedURLScheme
        }
    }

    func createURL(from location: Location) -> URL? {
        let urlString = "wikipedia://places?lat=\(location.lat)&lon=\(location.long)"
        return URL(string: urlString)
    }
}

struct MockCoordinator: Coordinator {
    func openURL(_ url: URL) async throws {
        
    }
    
    func createURL(from location: Location) -> URL? {
        return nil
    }
    
}
