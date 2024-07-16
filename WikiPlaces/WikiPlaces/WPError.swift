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
                return NSLocalizedString("error.validation.invalid_numbers", comment: "")
            case .latitudeOutOfBounds:
                return NSLocalizedString("error.validation.latitude_out_of_bounds", comment: "")
            case .longitudeOutOfBounds:
                return NSLocalizedString("error.validation.longitude_out_of_bounds", comment: "")
            }
        }
    }
    
    enum CoordinatorError: Error, LocalizedError {
        case cannotOpenURL
        case unsupportedURLScheme
        
        var errorDescription: String {
            switch self {
            case .cannotOpenURL:
                return NSLocalizedString("error.coordinator.cannot_open_url", comment: "")
            case .unsupportedURLScheme:
                return NSLocalizedString("error.coordinator.unsupported_url_scheme", comment: "")
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
                return NSLocalizedString("error.location_service.invalid_url", comment: "")
            case .fetchFailed(_):
                return NSLocalizedString("error.location_service.fetch_failed", comment: "")
            case .decodingFailed(_):
                return NSLocalizedString("error.location_service.decoding_failed", comment: "")
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
                return NSLocalizedString("error.network.unreachable", comment: "")
            case .timeout:
                return NSLocalizedString("error.network.timeout", comment: "")
            case .invalidResponse:
                return NSLocalizedString("error.network.invalid_response", comment: "")
            }
        }
    }
}
