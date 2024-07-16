//
//  WikiPlacesTests.swift
//  WikiPlacesTests
//
//  Created by Melina Ariyani on 13/07/2024.
//

@testable import WikiPlaces
import XCTest

final class WikiPlacesTests: XCTestCase {
    // MARK: Configuration
    
    var urlSession: URLSession!
    var viewModel = LocationViewModel(locationService: MockLocationService(), coordinator: MockCoordinator())
    
    override func tearDown() {
        urlSession = nil
        super.tearDown()
    }

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
    }
    
    // MARK: URL Creation
    
    func testCreateURL() {
        let coordinator = AppCoordinator()
        let location = Location(name: "String", lat: 37.7749, long: -122.4194)
        let url = coordinator.createURL(from: location)
        XCTAssertEqual(url?.absoluteString, "wikipedia://places?lat=37.7749&lon=-122.4194")
    }
    
    // MARK: Custom Location Input Validation
    
    func testAddCustomLocations() async {
        var location = Location(name: "String", lat: 37.7749, long: -122.4194)
        
        await viewModel.addCustomLocation(location: location)
        location.isCustom = true
        
        XCTAssertTrue(viewModel.locations.contains(location))
    }
    
    func testValidateLatitudeValid() throws {
        let validLatitude = "45.0"
        do {
            let latitude = try viewModel.validateLatitude(validLatitude)
            XCTAssertEqual(latitude, 45.0, "Latitude should be valid and equal to 45.0")
        } catch {
            XCTFail("Validation should not fail for valid latitude input")
        }
    }

    func testValidateLatitudeInvalidNumber() throws {
        let invalidLatitude = "abc"
        XCTAssertThrowsError(try viewModel.validateLatitude(invalidLatitude)) { error in
            XCTAssertTrue(error is WPError.ValidationError, "Error should be of type ValidationError.invalidNumbers")
        }
    }
    
    func testValidateLatitudeOutOfBounds() throws {
        let outOfBoundsLatitude = "91.0"
        XCTAssertThrowsError(try viewModel.validateLatitude(outOfBoundsLatitude)) { error in
            XCTAssertEqual(error as? WPError.ValidationError, WPError.ValidationError.latitudeOutOfBounds, "Latitude should trigger ValidationError.outOfBounds error")
        }
    }
    
    func testValidateLongitudeValid() throws {
        let validLongitude = "-123.0"
        do {
            let longitude = try viewModel.validateLongitude(validLongitude)
            XCTAssertEqual(longitude, -123.0, "Longitude should be valid and equal to -123.0")
        } catch {
            XCTFail("Validation should not fail for valid longitude input")
        }
    }

    func testValidateLongitudeInvalidNumber() throws {
        let invalidLongitude = "xyz"
        XCTAssertThrowsError(try viewModel.validateLongitude(invalidLongitude)) { error in
            XCTAssertTrue(error is WPError.ValidationError, "Error should be of type ValidationError.invalidNumbers")
        }
    }

    func testValidateLongitudeOutOfBounds() throws {
        let outOfBoundsLongitude = "-190.0"
        XCTAssertThrowsError(try viewModel.validateLongitude(outOfBoundsLongitude)) { error in
            XCTAssertEqual(error as? WPError.ValidationError, WPError.ValidationError.longitudeOutOfBounds, "Longitude should trigger ValidationError.outOfBounds error")
        }
    }

    // MARK: Location Service
    
    func testLoadLocations() async {
        let service = MockLocationService()
        await viewModel.loadLocations()
        
        XCTAssertTrue(viewModel.locations.contains(service.location))
    }
    
    func testFetchLocationsSuccess() async {
        let expectedData = """
        {
            "locations": [
                {"name": "Test Location", "lat": 40.7128, "long": -74.0060}
            ]
        }
        """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            (HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, expectedData)
        }

        let service = LocationService(session: urlSession)
        do {
            let locations = try await service.fetchLocations()
            XCTAssertEqual(locations.count, 1)
            XCTAssertEqual(locations.first?.name, "Test Location")
        } catch {
            XCTFail("Fetch failed: \(error)")
        }
    }
    
    func testFetchLocationsInvalidJSON() async {
        let invalidJSONData = "Invalid JSON".data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            (HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, invalidJSONData)
        }

        let service = LocationService(session: urlSession)
        do {
            let _ = try await service.fetchLocations()
            XCTFail("Should have failed due to decoding error")
        } catch WPError.LocationServiceError.decodingFailed {
            XCTAssert(true, "Caught decoding error as expected")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
