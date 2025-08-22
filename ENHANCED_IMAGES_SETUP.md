# Enhanced Product Images Feature Flag Setup

## Overview
This app now includes a sophisticated product image management system that mimics real-world CDN patterns. The system can toggle between generic SF Symbol icons and enhanced product images using LaunchDarkly feature flags.

## Feature Flag Setup

### 1. Create the Feature Flag in LaunchDarkly
1. **Go to LaunchDarkly Dashboard** → Feature Flags
2. **Click "Create Flag"**
3. **Configure the flag:**
   - **Key:** `enhanced-product-images`
   - **Name:** "Enhanced Product Images"
   - **Description:** "Toggle between generic shoe icons and enhanced stock photos"
   - **Variation Type:** Boolean
   - **Default Variations:**
     - `true` = Enhanced images enabled
     - `false` = Generic icons (current behavior)

### 2. Flag Behavior
- **Flag OFF (false):** Shows generic SF Symbol shoe icons
- **Flag ON (true):** Shows enhanced product images from CDN/local folder
- **Immediate effect:** No app restart required, changes happen in real-time

## Image Management System

### Local CDN Structure (Demo)
The app is set up to work with a local CDN folder structure:

```
YourProject/
├── CDN/
│   ├── products/
│   │   ├── trail-running/
│   │   │   ├── stride-pro-5/
│   │   │   │   ├── 150x150.jpg
│   │   │   │   ├── 300x300.jpg
│   │   │   │   └── 600x600.jpg
│   │   │   └── trailgrip-3/
│   │   ├── road-running/
│   │   │   ├── roadracer-x/
│   │   │   └── velocity-elite/
│   │   ├── cushion/
│   │   │   ├── cushionmax/
│   │   │   └── stabilizer-pro/
│   │   ├── performance/
│   │   │   └── velocity-elite/
│   │   ├── urban/
│   │   │   └── urban-dash/
│   │   ├── endurance/
│   │   │   └── marathoner/
│   │   ├── lightweight/
│   │   │   └── tempo-light/
│   │   ├── stability/
│   │   │   └── stabilize-pro/
│   │   └── general/
│   │       └── grip-x-trail/
│   └── fallbacks/
│       ├── default-shoe.jpg
│       └── error-shoe.jpg
```

### Image Sizes Available
- **thumbnail:** 150x150 (for lists)
- **card:** 300x300 (for product cards)
- **detail:** 600x600 (for product detail pages)
- **full:** 1200x1200 (for high-resolution views)

### Product Categorization
The system automatically categorizes products:
- **Trail Running:** TerraRun brand, trail-related names
- **Road Running:** SwiftCo brand, road-related names
- **Cushion:** CloudStep brand
- **Performance:** RapidOne brand
- **Urban:** MetroAth brand
- **Endurance:** Endurix brand
- **Lightweight:** FeatherRun brand
- **Stability:** FormFit brand
- **General:** Default category

## Implementation Details

### ProductImageService
- **Location:** `Sources/Services/Images/ProductImageService.swift`
- **Features:**
  - Automatic product categorization
  - Multiple image size support
  - Fallback to generic icons
  - Network CDN fallback
  - LaunchDarkly integration

### Usage in Views
```swift
// In ProductCardView
imageService.getProductImage(for: product, size: "card")

// In ProductDetailView  
imageService.getProductImage(for: product, size: "detail")
```

## Testing the Feature

### 1. With Flag OFF
- Product cards show generic shoe icons
- Product detail pages show generic icons
- Console shows "enhanced_images_enabled: false" in tracking

### 2. With Flag ON
- Product cards attempt to load enhanced images
- Falls back to generic icons if images aren't available
- Console shows "enhanced_images_enabled: true" in tracking

### 3. Adding Real Images
To see enhanced images working:
1. **Create the CDN folder structure** in your project
2. **Add product images** following the naming convention
3. **Add images to Xcode project** (make sure they're in the target)
4. **Toggle the feature flag ON** in LaunchDarkly

## Real-World Migration Path

### Phase 1: Demo Setup (Current)
- Local CDN folder structure
- Feature flag controls image source
- Fallback to generic icons

### Phase 2: Production CDN
- Replace local folder with actual CDN URLs
- Add image optimization and caching
- Implement image analytics

### Phase 3: Advanced Features
- Dynamic image sizing
- Image format optimization (WebP, AVIF)
- User-specific image targeting
- A/B testing different image sets

## Benefits

✅ **Instant Rollout** - Toggle images without app updates  
✅ **A/B Testing** - Measure impact of enhanced images on engagement  
✅ **Gradual Rollout** - Start with 10% of users, gradually increase  
✅ **Easy Rollback** - Turn off instantly if issues arise  
✅ **User Targeting** - Show enhanced images to specific user segments  
✅ **Performance Tracking** - See how image changes affect user behavior  
✅ **CDN Ready** - Easy migration to production CDN  

## Troubleshooting

### Images Not Showing
- Check that the feature flag is ON
- Verify CDN folder structure exists
- Ensure images are added to Xcode project target
- Check console for error messages

### Performance Issues
- Images are loaded asynchronously
- Generic icons serve as placeholders
- Network images have fallback to local icons

### Feature Flag Not Working
- Verify flag key is exactly `enhanced-product-images`
- Check LaunchDarkly connection status
- Ensure flag is enabled for your environment
