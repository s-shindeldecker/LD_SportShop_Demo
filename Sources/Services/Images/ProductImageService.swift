import SwiftUI
import UIKit

final class ProductImageService: ObservableObject {
    static let shared = ProductImageService()
    private init() {}
    
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
    
    func getProductImage(for product: Product, size: String = "card") -> some View {
        let enhancedImagesEnabled = LDService.shared.variation(
            forKey: "enhanced-product-images", 
            defaultValue: false
        )
        
        if enhancedImagesEnabled, let imageURL = productImageMap[product.id.uuidString] {
            // Enhanced image available - use network URL
            let sizedURL = getSizedImageURL(baseURL: imageURL, size: size)
            
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
        objectWillChange.send()
    }
}
