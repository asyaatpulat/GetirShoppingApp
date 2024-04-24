# Getir Shopping App

## Overview
The Getir Shopping App is a mobile application developed using Swift. It follows the VIPER design pattern for better separation of concerns and maintainability. The app allows users to browse products, view product details, add products to their basket, and view suggested products. It utilizes programmatic UI for creating the user interface and custom views. The app also integrates various third-party libraries such as SnapKit for layout constraints, SwiftLint for code linting, and Kingfisher for image downloading and caching. 🚀👩‍💻

## Screens

### Product Listing Screen
- The Product Listing Screen displays a list of products using a compositional layout. The layout consists of one vertical list and one horizontal list.
- Users can add or remove products to the basket directly from this screen.
- Users can navigate to the Product Detail Screen by clicking on a product cell.
- Users can navigate to the Product Basket Screen by using the basket button.

### Product Detail Screen
- The Product Detail Screen shows detailed information about a selected product.
- Users can view the product's image, price, name, and additional attributes.
- They can also add or remove the product to their basket directly from this screen.
- Users can navigate to the Product Basket Screen by using the basket button.

### Product Basket Screen
- The Product Basket Screen displays the products that the user has added to their basket and suggested products that comes from mock API.
- It utilizes a compositional layout, consisting of a vertical list for the user's selected products and a horizontal list for suggested products.
- Users can remove and add items from their basket or continue shopping by browsing suggested products.
- Users can see total price and click button to complete their shopping.
- Users can click the trash button to make their cart empty.

## Screenshots

<div style="display: flex; flex-wrap: wrap;">
    <img src="https://github.com/asyaatpulat/GetirShoppingApp/assets/102758706/203fb229-1da3-4e44-b2f3-def0e93ca525" alt="Ekran Resmi 2024-04-23 22 10 24" width="30%">
    <img src="https://github.com/asyaatpulat/GetirShoppingApp/assets/102758706/5037deb6-9766-415c-8b4f-c684622f3ee5" alt="Ekran Resmi 2024-04-23 22 11 08" width="30%">
    <img src="https://github.com/asyaatpulat/GetirShoppingApp/assets/102758706/31298700-494b-400e-a85f-d33a91f67c08" alt="Ekran Resmi 2024-04-23 22 10 38" width="30%">
</div>

<div style="display: flex; flex-wrap: wrap;">
    <img src="https://github.com/asyaatpulat/GetirShoppingApp/assets/102758706/3dca695a-2108-45ce-b919-2a886e628edf" alt="Ekran Resmi 2024-04-23 22 10 45" width="30%">
    <img src="https://github.com/asyaatpulat/GetirShoppingApp/assets/102758706/42219b98-62ad-412e-8ae4-d03ea640b855" alt="Ekran Resmi 2024-04-23 22 10 52" width="30%">
    <img src="https://github.com/asyaatpulat/GetirShoppingApp/assets/102758706/a5726959-23d7-483f-b0d6-23bc42dc37db" alt="Ekran Resmi 2024-04-23 22 10 58" width="30%">
</div>

## Functionality

### BasketManager
- The app uses UserDefaults to save and retrieve the user's basket, ensuring that their selections are preserved across classes.
- The Basket Manager handles operations such as adding, removing, and clearing items from the basket.

### NetworkManager
- The app communicates with the Getir Mock API using URLSession for fetching product data.
- Network requests are made to retrieve product listings and suggested products.

### Testing
- Unit tests are implemented to verify the functionality of various components within the app.

## Third-Party Libraries
- **SnapKit**: Used for creating layout constraints programmatically, offering a more flexible approach to UI development.
- **SwiftLint**: Ensures consistent coding style and enforces best practices, improving code readability and maintainability.
- **Kingfisher**: Handles image downloading and caching efficiently, enhancing the app's performance when loading product images.
  
## Requirements
- Xcode 15.0+

## Installation
1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or physical device.
