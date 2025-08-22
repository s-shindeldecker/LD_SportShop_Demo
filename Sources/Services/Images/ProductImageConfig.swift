import Foundation

/// Configuration file for product images - easy to update individual images
struct ProductImageConfig {
    
    /// Mapping of product IDs to their enhanced image URLs
    /// Update these URLs to change individual product images
    static let productImages: [String: String] = [
        // Stride Pro 5 - FleetPeak
        "2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop&crop=center",
        
        // RoadRacer X - SwiftCo
        "3EE48577-D2CG-5CF2-C1F2-FB6E02GF42A0": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=300&h=300&fit=crop&crop=center",
        
        // TrailGrip 3 - TerraRun
        "4FF59688-E3DH-6DG3-D2G3-GC7F13HG53B1": "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300&h=300&fit=crop&crop=center",
        
        // CushionMax - CloudStep
        "5GG60799-F4EI-7EH4-E3H4-HD8G24IH64C2": "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=300&h=300&fit=crop&crop=center",
        
        // Velocity Elite - RapidOne
        "6HH71800-G5FJ-8FI5-F4I5-IE9H35JI75D3": "https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=300&h=300&fit=crop&crop=center",
        
        // Urban Dash - MetroAth
        "7II82911-H6GK-9GJ6-G5J6-JF0I46KJ86E4": "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300&h=300&fit=crop&crop=center",
        
        // Marathoner - Endurix
        "8JJ93022-I7HL-0HK7-H6K7-KG1J57LK97F5": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=300&h=300&fit=crop&crop=center",
        
        // TempoLight - FeatherRun
        "9KK04133-J8IM-1IL8-I7L8-LH2K68ML08G6": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop&crop=center",
        
        // Stabilize Pro - FormFit
        "0LL15244-K9JN-2JM9-J8M9-MI3L79NM19H7": "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300&h=300&fit=crop&crop=center",
        
        // GripX Trail - TerraRun
        "1MM26355-L0KO-3KN0-K9N0-NJ4M80ON20I8": "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=300&h=300&fit=crop&crop=center"
    ]
    
    /// Product descriptions for reference
    static let productDescriptions: [String: String] = [
        "2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "Stride Pro 5 - FleetPeak",
        "3EE48577-D2CG-5CF2-C1F2-FB6E02GF42A0": "RoadRacer X - SwiftCo",
        "4FF59688-E3DH-6DG3-D2G3-GC7F13HG53B1": "TrailGrip 3 - TerraRun",
        "5GG60799-F4EI-7EH4-E3H4-HD8G24IH64C2": "CushionMax - CloudStep",
        "6HH71800-G5FJ-8FI5-F4I5-IE9H35JI75D3": "Velocity Elite - RapidOne",
        "7II82911-H6GK-9GJ6-G5J6-JF0I46KJ86E4": "Urban Dash - MetroAth",
        "8JJ93022-I7HL-0HK7-H6K7-KG1J57LK97F5": "Marathoner - Endurix",
        "9KK04133-J8IM-1IL8-I7L8-LH2K68ML08G6": "TempoLight - FeatherRun",
        "0LL15244-K9JN-2JM9-J8M9-MI3L79NM19H7": "Stabilize Pro - FormFit",
        "1MM26355-L0KO-3KN0-K9N0-NJ4M80ON20I8": "GripX Trail - TerraRun"
    ]
    
    /// How to update individual product images:
    /// 1. Find the product ID in the mapping above
    /// 2. Replace the URL with your new image URL
    /// 3. Make sure the new URL supports size parameters (w=300&h=300)
    /// 4. Test the change by toggling the feature flag
    
    /// Example of updating a single product image:
    /// "2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://your-new-image-url.com/image.jpg?w=300&h=300&fit=crop"
}
