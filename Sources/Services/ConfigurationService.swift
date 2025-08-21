import Foundation

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
