# Product Listing App

## Description

Product Listing App is an e-commerce application built using Flutter. It follows clean architecture with the BLoC pattern for state management.

## Features

- User authentication (login & registration)
- Home screen with banners and product listings
- Wishlist management
- Product search functionality
- Carousel for featured products

## Technologies Used

- **Flutter**: UI development
- **Flutter BLoC**: State management
- **FP Dart**: Functional programming utilities
- **Get It**: Dependency injection
- **HTTP**: API communication
- **Carousel Slider**: Image carousel

## Installation & Setup

### Prerequisites

Ensure you have the following installed:

- Flutter SDK (>=3.6.0)
- Dart SDK


### Install Dependencies

```sh
flutter pub get
```

### Configure API URLs

Update API endpoints in `lib/core/constants/urls.dart`:

```dart
class Urls {
  static const String baseUrl = 'https://admin.kushinirestaurant.com/api/';

  // Auth
  static const String verify = "verify/";
  static const String login = "login-register/";
  static const String userData = "user-data/";

  // Home
  static const String banners = 'banners/';
  static const String products = 'products/';
  static const String addRemoveWishlist = 'add-remove-wishlist/';
  static const String wishlist = 'wishlist/';
  static const String search = 'search/';
}
```

### Run the App


```sh
flutter run
```

## Folder Structure

```
lib/
|-- core/
|   |-- constants/
|   |-- common/
|   |-- utils/
|   |-- errors/
|   |-- use_case/
|   |-- dependencies/
|-- features/
|   |-- auth/
|   |-- home/
|   |-- wishlist/
|-- main.dart
```

## Assets

Ensure the assets directory is structured as follows:

```
assets/
|-- images/
```


