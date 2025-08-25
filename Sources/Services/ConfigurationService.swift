import Foundation
import SwiftUI
import Combine

/// Configuration file for product images - easy to update individual images
struct ProductImageConfig {
    
    /// Mapping of product IDs to their enhanced image URLs
    /// Update these URLs to change individual product images
    static let productImages: [String: String] = [
        // Stride Pro 5 - FleetPeak
        "2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop&crop=center",
        
        // RoadRacer X - SwiftCo
        "3EE48577-D2C6-5CF2-C1F2-FB6E02AF42A0": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=300&h=300&fit=crop&crop=center",
        
        // TrailGrip 3 - TerraRun
        "4FF59688-E3D4-6DA3-D2A3-AC7F13AA53B1": "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300&h=300&fit=crop&crop=center",
        
        // CushionMax - CloudStep
        "5AA60799-F4E1-7EA4-E3A4-BD8A24BA64C2": "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=300&h=300&fit=crop&crop=center",
        
        // Velocity Elite - RapidOne
        "6BB71800-A5F5-8FA5-F4A5-CE9B35CB75D3": "https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=300&h=300&fit=crop&crop=center",
        
        // Urban Dash - MetroAth
        "7CC82911-B6A6-9AA6-A5A6-DF0C46DC86E4": "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300&h=300&fit=crop&crop=center",
        
        // Marathoner - Endurix
        "8DD93022-C7B7-0BB7-B6B7-E01D57ED97F5": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=300&h=300&fit=crop&crop=center",
        
        // TempoLight - FeatherRun
        "9EE04133-D8C8-1CC8-C7C8-F12E68FE08A6": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop&crop=center",
        
        // Stabilize Pro - FormFit
        "0FF15244-E9D9-2DD9-D8D9-023F79AF19B7": "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300&h=300&fit=crop&crop=center",
        
        // GripX Trail - TerraRun
        "1AAA6355-F0E0-3EE0-E9E0-1340800020C8": "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=300&h=300&fit=crop&crop=center"
    ]
    
    /// Product descriptions for reference
    static let productDescriptions: [String: String] = [
        "2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "Stride Pro 5 - FleetPeak",
        "3EE48577-D2C6-5CF2-C1F2-FB6E02AF42A0": "RoadRacer X - SwiftCo",
        "4FF59688-E3D4-6DA3-D2A3-AC7F13AA53B1": "TrailGrip 3 - TerraRun",
        "5AA60799-F4E1-7EA4-E3A4-BD8A24BA64C2": "CushionMax - CloudStep",
        "6BB71800-A5F5-8FA5-F4A5-CE9B35CB75D3": "Velocity Elite - RapidOne",
        "7CC82911-B6A6-9AA6-A5A6-DF0C46DC86E4": "Urban Dash - MetroAth",
        "8DD93022-C7B7-0BB7-B6B7-E01D57ED97F5": "Marathoner - Endurix",
        "9EE04133-D8C8-1CC8-C7C8-F12E68FE08A6": "TempoLight - FeatherRun",
        "0FF15244-E9D9-2DD9-D8D9-023F79AF19B7": "Stabilize Pro - FormFit",
        "1AAA6355-F0E0-3EE0-E9E0-1340800020C8": "GripX Trail - TerraRun"
    ]
}

final class ProductImageService: ObservableObject {
    static let shared = ProductImageService()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        // Start observing flag changes when service is initialized
        observeFlagChanges()
    }
    
    // Get product images from configuration
    private var productImageMap: [String: String] {
        return ProductImageConfig.productImages
    }
    
    // Image sizes for different contexts
    private let imageSizes = [
        "thumbnail": "150x150",
        "card": "300x300", 
        "detail": "600x600",
        "full": "1200x1200"
    ]
    
    // Observe LaunchDarkly flag changes
    private func observeFlagChanges() {
        // Wait for LaunchDarkly to be ready, then observe flag changes
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            if LDService.shared.isReady {
                timer.invalidate()
                self?.startObservingFlagChanges()
            }
        }
    }
    
    private func startObservingFlagChanges() {
        // Observe the enhanced-product-images flag for changes
        LDService.shared.client?.observe(keys: ["enhanced-product-images"], owner: self) { [weak self] changes in
            DispatchQueue.main.async {
                print("🚀 LaunchDarkly: Flag 'enhanced-product-images' changed, refreshing UI...")
                self?.objectWillChange.send()
            }
        }
        
        // Also observe user context changes
        LDService.shared.$currentUserKey
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    print("👤 LaunchDarkly: User context changed, refreshing UI...")
                    self?.objectWillChange.send()
                }
            }
            .store(in: &cancellables)
    }
    
    func getProductImage(for product: Product, size: String = "card") -> some View {
        let enhancedImagesEnabled = LDService.shared.boolVariation(
            forKey: "enhanced-product-images", 
            defaultValue: false
        )
        
        // Enhanced debug logging for flag evaluation
        print("🔍 ProductImageService: Flag 'enhanced-product-images' = \(enhancedImagesEnabled) for user: \(LDService.shared.currentUserKey)")
        print("🔍 ProductImageService: Requesting image for product: \(product.name) (\(product.brand)) with size: \(size)")
        print("🔍 ProductImageService: Product ID: \(product.id.uuidString)")
        
        if enhancedImagesEnabled, let imageURL = productImageMap[product.id.uuidString] {
            // Enhanced image available - use network URL
            let sizedURL = getSizedImageURL(baseURL: imageURL, size: size)
            print("🖼️ ProductImageService: Using enhanced image for \(product.name): \(sizedURL)")
            print("🖼️ ProductImageService: Original URL from config: \(imageURL)")
            
            return AnyView(
                AsyncImage(url: URL(string: sizedURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    // Fallback to icon while loading
                    Image(systemName: product.imageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                }
            )
        }
        
        // Fallback to generic icon
        print("🎯 ProductImageService: Using generic icon for \(product.name)")
        print("🎯 ProductImageService: Enhanced images enabled: \(enhancedImagesEnabled)")
        if let imageURL = productImageMap[product.id.uuidString] {
            print("🎯 ProductImageService: Image URL exists in config: \(imageURL)")
        } else {
            print("🎯 ProductImageService: No image URL found in config for product ID: \(product.id.uuidString)")
        }
        
        return AnyView(
            Image(systemName: product.imageName)
                .resizable()
                .scaledToFit()
        )
    }
    
    private func getSizedImageURL(baseURL: String, size: String) -> String {
        // Update URL parameters for different sizes
        let sizeMap = [
            "thumbnail": "150x150",
            "card": "300x300",
            "detail": "600x600",
            "full": "1200x1200"
        ]
        
        let targetSize = sizeMap[size] ?? "300x300"
        
        // Replace or add size parameters to the URL
        if baseURL.contains("w=") && baseURL.contains("h=") {
            // URL already has size parameters, update them
            return baseURL.replacingOccurrences(of: "w=300&h=300", with: "w=\(targetSize.components(separatedBy: "x")[0])&h=\(targetSize.components(separatedBy: "x")[1])")
        } else {
            // URL doesn't have size parameters, add them
            let separator = baseURL.contains("?") ? "&" : "?"
            return "\(baseURL)\(separator)w=\(targetSize.components(separatedBy: "x")[0])&h=\(targetSize.components(separatedBy: "x")[1])&fit=crop&crop=center"
        }
    }
    
    private func getProductCategory(for product: Product) -> String {
        // Simple categorization based on product name/brand
        if product.name.lowercased().contains("trail") || product.brand == "TerraRun" {
            return "trail-running"
        } else if product.name.lowercased().contains("road") || product.brand == "SwiftCo" {
            return "road-running"
        } else if product.brand == "CloudStep" {
            return "cushion"
        } else if product.brand == "RapidOne" {
            return "performance"
        } else if product.brand == "MetroAth" {
            return "urban"
        } else if product.brand == "Endurix" {
            return "endurance"
        } else if product.brand == "FeatherRun" {
            return "lightweight"
        } else if product.brand == "FormFit" {
            return "stability"
        } else {
            return "general"
        }
    }
    
    func getProductImageURL(for product: Product, size: String = "card") -> String {
        if let imageURL = productImageMap[product.id.uuidString] {
            return getSizedImageURL(baseURL: imageURL, size: size)
        }
        
        // Fallback URL if no image is mapped
        return "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop&crop=center"
    }
    
    func refreshConfiguration() {
        // This could be called when LaunchDarkly configuration changes
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    // Manual refresh method - call this if you need to force a UI update
    func forceRefresh() {
        DispatchQueue.main.async {
            print("🔄 ProductImageService: Manual refresh triggered")
            self.objectWillChange.send()
        }
    }
    
    // Refresh when user context changes
    func refreshForNewUser() {
        DispatchQueue.main.async {
            print("👤 ProductImageService: Refreshing for new user context")
            self.objectWillChange.send()
        }
    }
}

final class ConfigurationService {
    static let shared = ConfigurationService()
    private init() {}
    
    // MARK: - LaunchDarkly Configuration
    var launchDarklyMobileKey: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["LaunchDarklyMobileKey"] as? String,
              !key.isEmpty,
              key != "YOUR_ACTUAL_MOBILE_KEY_HERE" else {
            fatalError("""
                LaunchDarkly mobile key not found or not configured in Config.plist
                
                Please:
                1. Open Config.plist
                2. Replace 'YOUR_ACTUAL_MOBILE_KEY_HERE' with your actual LaunchDarkly mobile key
                3. The mobile key should start with 'mob-' and can be found in your LaunchDarkly dashboard under Settings > Keys
                """)
        }
        return key
    }
    
    var launchDarklyEnvironment: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let environment = dict["LaunchDarklyEnvironment"] as? String else {
            return "development"
        }
        return environment
    }
    
    // MARK: - App Configuration
    var companyName: String {
        return "SportFlex Pro"
    }
    
    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    var buildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
}
