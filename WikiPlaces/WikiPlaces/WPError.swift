//
//  WPError.swift
//  WikiPlaces
//
//  Created by Melina Ariyani on 15/07/2024.
//

import Foundation

struct WPError: Error, LocalizedError {
    
    enum ValidationError: Error, LocalizedError {
        case invalidNumbers
        case latitudeOutOfBounds
        case longitudeOutOfBounds
        
        var errorDescription: String {
            switch self {
            case .invalidNumbers:
                return "Please enter valid numbers for latitude and longitude."
            case .latitudeOutOfBounds:
                return "Latitude must be between -90 and 90 degrees."
            case .longitudeOutOfBounds:
                return "Longitude must be between -180 and 180 degrees."
            }
        }
    }
    
    enum CoordinatorError: Error, LocalizedError {
        case cannotOpenURL
        case unsupportedURLScheme
        
        var errorDescription: String {
            switch self {
            case .cannotOpenURL:
                return "Failed to open URL. Please check the format."
            case .unsupportedURLScheme:
                return "This URL scheme is not supported. Please check if the Wikipedia app is installed."
            }
        }
    }
    
    enum LocationServiceError: Error, LocalizedError {
        case invalidURL
        case fetchFailed(Error)
        case decodingFailed(Error)
        
        var errorDescription: String {
            switch self {
            case .invalidURL:
                return "The URL provided is invalid."
            case .fetchFailed(let error):
                return "Failed to fetch locations. \(error.localizedDescription)"
            case .decodingFailed(let error):
                return "Failed to decode the locations. \(error.localizedDescription)"
            }
        }
    }
    
    enum NetworkError: Error, LocalizedError {
        case unreachable
        case timeout
        case invalidResponse
        
        var errorDescription: String {
            switch self {
            case .unreachable:
                return "The network is unreachable. Please check your connection."
            case .timeout:
                return "The request timed out. Please try again later."
            case .invalidResponse:
                return "Received an invalid response from the server."
            }
        }
    }
}
