//
//  AppCoordinator.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 13/07/2024.
//

import Foundation
import SwiftUI

protocol Coordinator {
    func openLocation(_ location: Location)
}

class AppCoordinator: Coordinator {
    func openLocation(_ location: Location) {
        let urlString = "wikipedia://places?lat=\(location.lat)&lon=\(location.long)"
        
        if let url = URL(string: urlString) {
            print("urlString: \(url.absoluteString)")
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL")
            }
        }
    }
}
