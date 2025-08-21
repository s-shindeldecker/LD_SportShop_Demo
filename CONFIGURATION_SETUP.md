# Configuration Setup Guide

## Overview
This app uses a `Config.plist` file to manage sensitive configuration values like LaunchDarkly API keys. This file is intentionally not tracked by git to keep your keys secure.

## Initial Setup

### 1. Configure LaunchDarkly
1. Open `Config.plist` in Xcode or any text editor
2. Replace `YOUR_ACTUAL_MOBILE_KEY_HERE` with your actual LaunchDarkly mobile key
3. The mobile key should start with `mob-` and can be found in your LaunchDarkly dashboard under **Settings > Keys**

### 2. Example Config.plist
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>LaunchDarklyMobileKey</key>
    <string>mob-abc123def456-789</string>
    <key>LaunchDarklyEnvironment</key>
    <string>development</string>
</dict>
</plist>
```

## Security Features

✅ **Config.plist is in .gitignore** - won't be committed to version control  
✅ **Validation checks** - app will crash with helpful error if key is missing/invalid  
✅ **Environment separation** - can use different keys for dev/staging/prod  
✅ **Clear error messages** - tells you exactly what to do if configuration is wrong  

## What Happens If You Don't Configure

If you run the app without configuring `Config.plist`:
- The app will crash on launch
- You'll see a clear error message explaining what to do
- The error includes step-by-step instructions

## Adding New Configuration Values

To add new configuration values:

1. **Add to Config.plist:**
```xml
<key>NewConfigKey</key>
<string>NewConfigValue</string>
```

2. **Add to ConfigurationService.swift:**
```swift
var newConfigValue: String {
    guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
          let dict = NSDictionary(contentsOfFile: path),
          let value = dict["NewConfigKey"] as? String else {
        fatalError("NewConfigKey not found in Config.plist")
    }
    return value
}
```

## Troubleshooting

### "LaunchDarkly mobile key not found" Error
- Check that `Config.plist` exists in your project root
- Verify the key name is exactly `LaunchDarklyMobileKey`
- Make sure you've replaced the placeholder text with your actual key

### Build Errors
- Ensure `Config.plist` is added to your Xcode project target
- Check that the file is in the correct location (project root)
- Verify the plist format is valid XML

## Best Practices

- **Never commit** `Config.plist` to version control
- **Use different keys** for development, staging, and production
- **Keep a template** of `Config.plist` with placeholder values
- **Document** any new configuration values you add
