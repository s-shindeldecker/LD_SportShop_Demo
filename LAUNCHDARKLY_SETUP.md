# LaunchDarkly Setup Guide

## Overview
This app uses LaunchDarkly for feature flag management. The 401 errors you're seeing indicate that the LaunchDarkly mobile key is not properly configured.

## Quick Fix
1. Open `Sources/App/AppConfig.swift`
2. Replace `"YOUR_DEV_MOBILE_KEY"` with your actual LaunchDarkly mobile key
3. For production builds, also replace `"YOUR_PROD_MOBILE_KEY"`

## Getting Your Mobile Key
1. Log into your LaunchDarkly dashboard
2. Go to **Settings** > **Keys**
3. Copy the **Mobile key** (not the Client-side ID)
4. The mobile key starts with `mob-` and is different from your client-side key

## Configuration Options

### Option 1: Direct Configuration (Development)
```swift
static let launchDarklyMobileKey: String = "mob-your-actual-key-here"
```

### Option 2: Environment Variables (Production)
```swift
static let launchDarklyMobileKey: String = {
    return ProcessInfo.processInfo.environment["LAUNCHDARKLY_MOBILE_KEY"] ?? "fallback-key"
}()
```

### Option 3: Configuration File
Create a separate configuration file that's not committed to version control:
```swift
// Config.plist or similar
static let launchDarklyMobileKey: String = {
    guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
          let dict = NSDictionary(contentsOfFile: path),
          let key = dict["LaunchDarklyMobileKey"] as? String else {
        fatalError("LaunchDarkly mobile key not found in Config.plist")
    }
    return key
}()
```

## Testing
After setting the correct key:
1. Clean and rebuild your project
2. Check the console for LaunchDarkly connection messages
3. The 401 errors should disappear
4. You should see successful LaunchDarkly initialization

## Security Notes
- Never commit your actual LaunchDarkly keys to version control
- Use different keys for development, staging, and production
- Consider using environment variables or secure configuration management for production builds
