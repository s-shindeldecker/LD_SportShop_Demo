import SwiftUI
import UIKit

final class ProductImageService: ObservableObject {
    static let shared = ProductImageService()
    private init() {}
    
    // For demo: use local CDN folder structure
    private let cdnBaseURL = "https://images.sportflex.com/products"
    
    // Demo: Map product IDs to local image names
    private let productImageMap: [String: String] = [
        "2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "stride-pro-5",
        "3EE48577-D2CG-5CF2-C1F2-FB6E02GF42A0": "roadracer-x",
        "4FF59688-E3DH-6DG3-D2G3-GC7F13HG53B1": "trailgrip-3",
        "5GG60799-F4EI-7EH4-E3H4-HD8G24IH64C2": "cushionmax",
        "6HH71800-G5FJ-8FI5-F4I5-IE9H35JI75D3": "velocity-elite",
        "7II82911-H6GK-9GJ6-G5J6-JF0I46KJ86E4": "urban-dash",
        "8JJ93022-I7HL-0HK7-H6K7-KG1J57LK97F5": "marathoner",
        "9KK04133-J8IM-1IL8-I7L8-LH2K68ML08G6": "tempo-light",
        "0LL15244-K9JN-2JM9-J8M9-MI3L79NM19H7": "stabilize-pro",
        "1MM26355-L0KO-3KN0-K9N0-NJ4M80ON20I8": "grip-x-trail"
    ]
    
    // Image sizes (common CDN pattern)
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
        
        if enhancedImagesEnabled, let imageName = productImageMap[product.id.uuidString] {
            // Try to load from local CDN folder
            let imagePath = "CDN/products/\(getProductCategory(for: product))/\(imageName)/\(size).jpg"
            
            if let image = UIImage(named: imagePath) {
                return AnyView(
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                )
            } else {
                // Fallback to network CDN
                let cdnURL = "\(cdnBaseURL)/\(getProductCategory(for: product))/\(imageName)/\(size).jpg"
                return AnyView(
                    AsyncImage(url: URL(string: cdnURL)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        Image(systemName: product.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                )
            }
        }
        
        // Fallback to generic icon
        return AnyView(
            Image(systemName: product.imageName)
                .resizable()
                .scaledToFit()
        )
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
        // Real-world pattern: /products/{category}/{product-id}/{size}.jpg
        let category = getProductCategory(for: product)
        let sizeSuffix = imageSizes[size] ?? "300x300"
        
        if let imageName = productImageMap[product.id.uuidString] {
            return "\(cdnBaseURL)/\(category)/\(imageName)/\(sizeSuffix).jpg"
        }
        
        return "\(cdnBaseURL)/fallbacks/default-shoe.jpg"
    }
    
    func refreshConfiguration() {
        // This could be called when LaunchDarkly configuration changes
        objectWillChange.send()
    }
}
