# Shop Smart - User Version/User Side

Shop Smart is an e-commerce mobile app that allows users to shop for various products conveniently. This README provides an overview of its features and functionalities.

## Features

1. **User-Friendly UI**
   - Locked device orientation for portrait mode.
   - Implemented light and dark themes using Provider State Management.
   - Created custom text widgets for a unique look.
   - Designed a responsive bottom navigation bar with state management.

2. **Profile Management**
   - Users can access their profiles.
   - Implemented an animated background widget using Gmail.
   - Designed screens for managing user profiles and account settings.

3. **Shopping Cart**
   - Users can view their shopping cart.
   - Created dialogs for adjusting item quantities.
   - Implemented a cart badge for easy cart access.

4. **Product Search**
   - Users can search for products.
   - Designed and finalized the search screen.

5. **Home Screen**
   - Implemented a swipe feature for the home screen.
   - Created widgets for displaying the latest arrivals and product categories.
   
6. **Product Details**
   - Users can view detailed product information.
   - Designed a custom heart widget for favoriting products.
   - Implemented a wish list and recently viewed products.

7. **User Authentication**
   - Created login and registration screens.
   - Added a Google sign-in option.
   - Implemented profile image and picture selection.
   - Users can reset forgotten passwords.

8. **State Management**
   - Utilized Provider for efficient state management.
   - Created a product model for accurate data handling.
   - Managed the shopping cart with dynamic updates.

9. **Firebase Integration**
   - Connected the app to Firebase.
   - Enabled user registration and error handling.
   - Implemented user authentication and information storage.
   - Fetched products from Firebase and displayed them in the app.
   - Managed user orders and displayed them in the app.

## Dependencies

Shop Smart relies on several dependencies to provide its features. You can include these dependencies in your `pubspec.yaml` file as follows:

```yaml
dependencies:
  card_swiper: ^3.0.1
  cloud_firestore: ^4.9.2
  cupertino_icons: ^1.0.2
  dynamic_height_grid_view: ^0.0.3
  fancy_shimmer_image: ^2.0.3
  firebase_auth: ^4.10.0
  firebase_core: ^2.16.0
  firebase_storage: ^11.2.7
  flutter:
    sdk: flutter
  flutter_iconly: ^1.0.2
  fluttertoast: ^8.2.2
  google_sign_in: ^6.1.5
  image_picker: ^1.0.4
  ionicons: ^0.2.2
  provider: ^6.0.5
  shared_preferences: ^2.2.1
  shimmer: ^3.0.0
  uuid: ^4.0.0
```

## Usage

To get started with Shop Smart, follow these steps:
1. Clone this repository.
2. Ensure you have Flutter installed.
3. Run the app on your preferred device using Flutter.

Feel free to explore and enjoy a seamless shopping experience!

