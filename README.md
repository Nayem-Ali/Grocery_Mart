
# Grocery Mart
This is an online grocery shopping app.    
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)    
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)    
![Android Studio](https://img.shields.io/badge/android%20studio-346ac1?style=for-the-badge&logo=android%20studio&logoColor=white)  
![DummyJSON](https://img.shields.io/badge/dummyjson-000000?style=for-the-badge&logo=json&logoColor=white)


## Tech Stack

- **Flutter:** 3.32.0
- **Dart:** 3.8.0
- **Architecture:** Simplified Architecture as Instructed
- **State Management:** BLoC
- **Routing:** GoRouter
- **Local Storage:** Shared Preferences

## Installation

### Prerequisites

- Flutter `3.32.0` installed → [Flutter SDK Install Guide](https://docs.flutter.dev/get-started/install)
- Dart `3.8.0`
- Android Studio or VS Code
- An emulator, simulator or physical device connected

### Steps to run

1. **Clone the repository:**    
   ```git clone https://github.com/Nayem-Ali/Grocery_Mart.git```
2. **Redirect to Cloned Project Folder:**    
   ```cd Grocery_Mart```
3. **Install Dependencies:**    
   ```flutter pub get```
4. **Run the app**    
   ```flutter run```

## Data Collection
- Sample data collected from [DummyJson Products API](https://dummyjson.com/docs/products)
- Reformatted sample data path in this Repo: `Grocery_Mart/assets/json/products.json`

## Technical Decisions
1. **Data Collection & Preparation**  
   Product data was collected from the DummyJson API. The JSON response was then reformatted and structured to fit the specific data model and architecture of the project.
2. **Cart Item Persistence**  
   For persisting cart items locally, I used SharedPreferences with List<String>, where each cart item is stored as a serialized Map<String, dynamic> (via jsonEncode/jsonDecode).  
   To avoid duplicate entries and maintain data consistency, each time a new product is added, the existing list is first retrieved and checked for item existence before insertion. This results in an O(n) lookup, which is acceptable for small lists but could be optimized in future versions using more efficient data structures or a local database like Sembast or Hive.
3. **Efficient and Scalable Routing**  
   I chose GoRouter for navigation to handle future scalability, deep linking, and complex nested routing scenarios. It simplifies route management and integrates well with Flutter’s declarative navigation model.
4. **Loose Coupling with Dependency Injection**  
   To achieve a modular and loosely coupled architecture, I used get_it for dependency injection. This improves code testability, reusability, and separation of concerns across layers (data, domain, and UI).
5. **State Management**  
   While Provider would have sufficed for a small app, I opted for BLoC for better state separation, testability, and scalability. BLoC’s event-driven architecture supports more complex business logic and ensures predictable state transitions as the app grows.
6. **Image Caching**  
   To optimize performance and reduce unnecessary network requests, I used cached_network_image. This ensures images are cached locally after the first load, providing a smoother user experience and lower bandwidth usage.

## Challenge & Solution
### Challenge

I had no prior experience with **BLoC** or **Provider**, which made choosing the right state management approach confusing. It was important to pick a solution that would scale well and remain maintainable as the app grew.

### Solution

I chose **BLoC** for its scalability, clean architecture, and testability. To learn BLoC, I followed these helpful resources:

-   [Understanding the BLoC Pattern in Flutter: A Practical Approach](https://blog.stackademic.com/understanding-the-bloc-pattern-in-flutter-a-practical-approach-244ab23e2315)

-   [Mastering State Management in Flutter with Bloc: A Comprehensive Guide](https://medium.com/@dihsar/mastering-state-management-in-flutter-with-bloc-a-comprehensive-guide-1d03319ba7df)

-   [Flutter BloC Pattern Tutorial](https://youtu.be/rVI6IR1JiVA?si=8tlyYoCJqYhwvBCI)

-   [BLoC State Management Tutorial - Flutter Bangla Tutorial](https://youtu.be/lOx09xrCg6g?si=TAV8y_8iPqqcrh7i)

These helped me understand event-state flow and implement BLoC in the project.

## Time Breakdown

| Day     | Tasks                                                                                           |
|---------|--------------------------------------------------------------------------------------------------|
| **Day 1** | - Project planning and data collection from DummyJson<br>- Setup project structure<br>- Installed required packages<br>- Configured GoRouter for navigation<br>- Set up SharedPreferences<br>- Implemented dependency injection with `get_it`<br>- Created splash and navigation screens |
| **Day 2** | - Developed product features (must-have and good-to-have)<br>- Implemented cart functionality<br>- Managed cart data using SharedPreferences for local persistence |
| **Day 3** | - Refined and polished UI<br>- Fixed bugs and performed testing<br>- Created README and technical documentation |

**This project helps to learn about Bloc Pattern**

## Screenshots

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/f78bafe9-b09e-4f8d-a9ed-c8725f3a1383" alt="Splash Screen" width="200" height="400"/></td>
    <td><img src="https://github.com/user-attachments/assets/ca173799-4fa4-4845-9d91-148b11410dde" alt="Home Screen" width="200" height="400"/></td>
    <td><img src="https://github.com/user-attachments/assets/0c781e52-3a6b-4e43-bd2c-618327324eb0" alt="Category" width="200" height="400"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/f9f449dc-e995-45a6-8d1c-ad6072fb446f" alt="Cart" width="200" height="400"/></td>
    <td><img src="https://github.com/user-attachments/assets/6ec7edd3-81bd-4ca6-b671-adb61c433b26" alt="Product Details" width="200" height="400"/></td>
    <td><img src="https://github.com/user-attachments/assets/d93047a0-eafd-49cf-b56c-0e10318bf128" alt="Categorized Products" width="200" height="400"/></td>
  </tr>
</table>







## Video Demo
