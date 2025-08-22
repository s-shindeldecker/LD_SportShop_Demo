# Product Image Update Guide

## Quick Update Instructions

### 1. Find the Product Image Configuration
Open `Sources/Services/Images/ProductImageConfig.swift`

### 2. Locate the Product You Want to Update
Find the product ID in the `productImages` dictionary:

```swift
// Example: Update Stride Pro 5 image
"2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop&crop=center",
```

### 3. Replace the URL
Change the URL to your new image:

```swift
"2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://your-new-image-url.com/image.jpg?w=300&h=300&fit=crop",
```

### 4. Test the Change
1. Build and run the app
2. Toggle the `enhanced-product-images` feature flag ON in LaunchDarkly
3. Navigate to the product to see the new image

## Product ID Reference

| Product Name | Brand | Product ID |
|--------------|-------|------------|
| Stride Pro 5 | FleetPeak | `2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9` |
| RoadRacer X | SwiftCo | `3EE48577-D2CG-5CF2-C1F2-FB6E02GF42A0` |
| TrailGrip 3 | TerraRun | `4FF59688-E3DH-6DG3-D2G3-GC7F13HG53B1` |
| CushionMax | CloudStep | `5GG60799-F4EI-7EH4-E3H4-HD8G24IH64C2` |
| Velocity Elite | RapidOne | `6HH71800-G5FJ-8FI5-F4I5-IE9H35JI75D3` |
| Urban Dash | MetroAth | `7II82911-H6GK-9GJ6-G5J6-JF0I46KJ86E4` |
| Marathoner | Endurix | `8JJ93022-I7HL-0HK7-H6K7-KG1J57LK97F5` |
| TempoLight | FeatherRun | `9KK04133-J8IM-1IL8-I7L8-LH2K68ML08G6` |
| Stabilize Pro | FormFit | `0LL15244-K9JN-2JM9-J8M9-MI3L79NM19H7` |
| GripX Trail | TerraRun | `1MM26355-L0KO-3KN0-K9N0-NJ4M80ON20I8` |

## Image Requirements

### URL Format
Your image URL should support size parameters:
- **Card size:** `?w=300&h=300&fit=crop`
- **Detail size:** `?w=600&h=600&fit=crop`
- **Thumbnail:** `?w=150&h=150&fit=crop`

### Recommended Image Sources
- **Unsplash** - Free high-quality photos
- **Pexels** - Free stock photos
- **Pixabay** - Free images
- **Your own CDN** - For production use

### Image Specifications
- **Aspect ratio:** 1:1 (square) works best
- **Minimum resolution:** 600x600 pixels
- **Format:** JPG, PNG, or WebP
- **File size:** Keep under 500KB for performance

## Example Updates

### Update Single Product
```swift
// Before
"2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://old-image.jpg?w=300&h=300&fit=crop",

// After
"2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://new-image.jpg?w=300&h=300&fit=crop",
```

### Update Multiple Products
```swift
// Update several products at once
"2DD37466-C1BF-4BE1-B0E1-EA5D91FE31D9": "https://new-stride-pro.jpg?w=300&h=300&fit=crop",
"3EE48577-D2CG-5CF2-C1F2-FB6E02GF42A0": "https://new-roadracer.jpg?w=300&h=300&fit=crop",
"4FF59688-E3DH-6DG3-D2G3-GC7F13HG53B1": "https://new-trailgrip.jpg?w=300&h=300&fit=crop",
```

## Troubleshooting

### Image Not Showing
- Check that the URL is valid and accessible
- Ensure the URL supports size parameters
- Verify the feature flag is ON
- Check console for network errors

### Wrong Image Size
- Make sure your URL includes size parameters
- Test with different size values (300x300, 600x600)
- Check that the image service is using the correct size

### Performance Issues
- Use optimized images (WebP format if possible)
- Keep file sizes reasonable
- Consider using a CDN for production

## Next Steps

1. **Test with current images** - Toggle the feature flag to see enhanced images
2. **Update individual products** - Replace URLs for specific products
3. **Add your own images** - Upload to your preferred image service
4. **Optimize for production** - Use your own CDN when ready
