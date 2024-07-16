# Wikipedia Places Viewer App
#### Melina Ariyani | iOS Assignment

## Overview

This project is a modification of the official [Wikipedia iOS app](https://github.com/wikimedia/wikipedia-ios), focused on enhancing its Places tab functionality, and creating a WikiPlaces test app to test the deeplinking function. The app has been modified to open directly to a specified location via coordinates provided by deep linking from the WikiPlaces test app, rather than using the device's current location. The WikiPlaces test app fetches a remote list of locations and populates a list of Locations that the user can select to open in the Wikipedia app.
  
## Features

- ****List of Locations:**** The test app fetches locations from a remote JSON file and displays them in a list.

- ****Deep Linking to Places Tab:**** Opens the Wikipedia app directly to the Places tab showing the specified coordinates of the selected location.

- ****Custom Location Entry:**** Users can enter a custom location in the WikiPlaces app by selecting the plus icon top right corner, opening a form for the user to specify a name and the lat/lon coordinates of the location.

  
## How to run the project

### Prerequisites

- Xcode 12.0 or later

- iOS 14.0 or later

  
### Running the App

1. Open `Wikipedia.xccodeproj` in Xcode

2. Select your preferred target device/simulator

3. Run the **Wikipedia** app using `Cmd + R`

4. Open `WikiPlaces.xccodeproj` in Xcode

5. Select the same target device/simulator as in Step 2.

6. Run the **WikiPlaces** app using `Cmd + R`

## Usage

Upon launching the test app, you will see a list of locations:

- Tap on any location to open the Wikipedia app directly at the Places tab, displaying the tapped location.

- Tap on the plus icon in the top right corner to open a form for adding a custom location. Use the input fields to enter the name and coordinates for a custom location, which can then be viewed in the Wikipedia app via deep linking.

## Deep Linking | Wikipedia App

The modified Wikipedia app supports the following URL scheme for deep linking:
```
wikipedia://places?lat=<latitude>&lon=<longitude>
```

### Example

To open the Wikipedia app at the coordinates for New York City:
```
wikipedia://places?lat=40.712776&lon=-74.005974
```

### Modifications
The Wikipedia app has had the following changes made:

- `NSUsersActivity+WMFExtensions.m`
Modified the `wmf_placesActivityWithURL` function to be able to extract latitudinal and longitudinal coordinates from an activityURL and add those coordinates to the userActivity object.
- `PlacesViewController.m`
Implemented an additional function `updateMapWithCustomCoordinates` taking a latitude and longitude as string arguments and calling a pre-existing function that navigates to the location within the map view.
- `WMFAppViewController.m`
Modified the `processingUserActivity` function to pass the retrieved lat and long coordinates through to the `updateMapWithCustomCoordinates` function.

## Development | WikiPlaces App

### Architecture

The WikiPlaces app is built using SwiftUI and leverages Swift Concurrency for handling asynchronous tasks such as network requests. It is also architected with a MVVM-C pattern for reusability and seperation of concerns.

### Accessibility

Accessibility features such as Dark Mode and dynamic text sizing are supported to ensure the app is usable by individuals with visual impairments.

## Testing

Unit tests are included to verify the functionality of data retrieval, data parsing, input validation, and the deep linking mechanism. Each test is designed to be self-contained, using asynchronous operations where necessary to accommodate the testing of concurrent tasks. They aim to cover both positive and error-handling scenarios, ensuring the application behaves correctly under various expected and unexpected conditions.

Run the tests by using the shortcut `Cmd + U`.

## Areas of Improvement
- Data persistence: Currently the app does not persist the added custom locations. If it was stored, there would also be the possibility to delete locations as well.
- More extensive unit tests: Only 11 tests have been implemented for the WikiPlaces app, and they are testing basic functionality.
- Extended compatibility: Despite the name 'WikiApp', it would be nice to support other URL schemes to give the user an option to choose a map based application of their preference (given that it can be deeplinked to).
- Improved UX for adding custom location: Currently the Add Location functionality is in a form layout, asking the user for coordinates which is not always ideal. An optimised way to modify this feature would be to present a map that the user can drag a pin on, to then select their own location on a map, rather than input coordinates.
