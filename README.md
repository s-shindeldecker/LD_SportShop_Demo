# LD Sport Shop Demo

A SwiftUI iOS application demonstrating LaunchDarkly feature flag integration for an e-commerce sports shop.

## Features
- Product catalog with running shoes
- Feature flag management via LaunchDarkly
- Analytics tracking and user behavior monitoring
- Clean navigation with proper back button handling
- Modern SwiftUI interface with custom theming

## Requirements
- iOS 18.6+
- Xcode 16.0+
- Swift 6.0+

## Setup
1. Clone the repository
2. Open `LD_SportShop_Demo.xcodeproj` in Xcode
3. Replace `"YOUR_MOBILE_KEY"` in `LDShopDemoApp.swift` with your LaunchDarkly mobile key
4. Build and run

## LaunchDarkly Configuration
See `LAUNCHDARKLY_SETUP.md` for detailed setup instructions.

## Architecture
- **MVVM Pattern** with ObservableObject state management
- **Router-based Navigation** using SwiftUI NavigationStack
- **Feature-based Folder Structure** for scalable code organization
- **Service Layer** for LaunchDarkly and Analytics integration

## Project Structure
