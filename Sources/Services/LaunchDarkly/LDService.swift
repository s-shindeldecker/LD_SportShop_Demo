import Foundation
import LaunchDarkly

final class LDService: ObservableObject {
    static let shared = LDService()
    private init() {}
    
    @Published private(set) var isReady = false
    @Published private(set) var currentUserKey: String = "default-user"
    private(set) var client: LDClient?
    
    // Start LaunchDarkly service with a new random user context
    func start(mobileKey: String) {
        // Generate a new random user ID for this app session
        let sessionUserId = "session-\(UUID().uuidString.prefix(8))"
        
        print("🚀 LaunchDarkly: Starting with user context: \(sessionUserId)")
        
        // Start with the new random user context
        startWithUserContext(userKey: sessionUserId)
    }
    
    private func startWithUserContext(userKey: String) {
        let config = LDConfig(mobileKey: ConfigurationService.shared.launchDarklyMobileKey, autoEnvAttributes: .init(rawValue: 0)!)
        
        // Start client without context for now (we'll handle user switching differently)
        LDClient.start(config: config) { [weak self] in
            self?.client = LDClient.get()
            self?.currentUserKey = userKey
            self?.isReady = true
            print("🚀 LaunchDarkly: Started with user context: \(userKey)")
            
            // Now identify the user to LaunchDarkly
            self?.identifyUser(userKey: userKey)
        }
    }
    

    
    // Force a complete refresh of the LaunchDarkly connection
    func forceRefresh() {
        print("🔄 LaunchDarkly: Force refreshing connection...")
        
        // Create a new client instance
        let config = LDConfig(mobileKey: ConfigurationService.shared.launchDarklyMobileKey, autoEnvAttributes: .init(rawValue: 0)!)
        
        LDClient.start(config: config) { [weak self] in
            DispatchQueue.main.async {
                self?.client = LDClient.get()
                self?.isReady = true
                print("🔄 LaunchDarkly: Connection refreshed")
                
                // Notify observers
                self?.objectWillChange.send()
            }
        }
    }
    
    func variation<T>(forKey key: String, defaultValue: T) -> T where T: LDValueConvertible, T: Decodable {
        guard let client else { return defaultValue }
        
        // Get the raw flag value from LaunchDarkly
        let flagValue = client.variation(forKey: key, defaultValue: defaultValue)
        
        // Debug logging to see what we're getting
        print("🔍 LaunchDarkly: Raw flag value for '\(key)': \(flagValue)")
        
        return flagValue
    }
    
    // Special method for boolean flags to ensure proper conversion
    func boolVariation(forKey key: String, defaultValue: Bool) -> Bool {
        guard let client else { return defaultValue }
        
        // Get the raw flag value from LaunchDarkly
        let rawValue = client.variation(forKey: key, defaultValue: defaultValue)
        
        // Debug logging to see exactly what we're getting
        print("🔍 LaunchDarkly: Boolean flag '\(key)' raw value: \(rawValue), type: \(type(of: rawValue)) for user: \(currentUserKey)")
        
        // TODO: The issue is that LaunchDarkly is returning variation: Optional(1) but we're converting it to false
        // This suggests either:
        // 1. The flag value is actually true (1) but we're not handling it correctly, OR
        // 2. There's a conversion issue in our code
        // 3. LaunchDarkly is seeing all users as the same anonymous user
        
        // Ensure we return the correct boolean value
        return rawValue
    }
    
    // Method to set user attributes that LaunchDarkly can use for targeting
    func setUserAttribute(_ value: String, forKey key: String) {
        // This would ideally set user attributes for LaunchDarkly targeting
        // For now, we'll just log it to help with debugging
        print("👤 LaunchDarkly: Setting user attribute '\(key)' = '\(value)' for user: \(currentUserKey)")
    }
    
    // Predefined set of users for consistent testing
    let predefinedUsers = [
        "user-alice-001",
        "user-bob-002", 
        "user-carol-003",
        "user-dave-004",
        "user-eve-005",
        "user-frank-006",
        "user-grace-007",
        "user-henry-008",
        "user-iris-009",
        "user-jack-010"
    ]
    
    // Generate a new random user context for LaunchDarkly experiments
    func generateNewUserContext() {
        // Generate a random user ID for new user simulation
        let randomUserId = "random-user-\(UUID().uuidString.prefix(8))"
        
        print("🔄 LaunchDarkly: Generating new random user: \(randomUserId)")
        
        // Switch to the new random user
        switchToUser(userKey: randomUserId)
    }
    
    // Switch to a specific predefined user
    func switchToUser(userKey: String) {
        print("🔄 LaunchDarkly: Switching to specific user: \(userKey)")
        
        // Store the new user key
        self.currentUserKey = userKey
        
        // Identify the new user to LaunchDarkly
        identifyUser(userKey: userKey)
        
        // Notify observers that context changed
        self.objectWillChange.send()
        
        // Also refresh the ProductImageService
        ProductImageService.shared.refreshForNewUser()
    }
    
    // Actually identify the user to LaunchDarkly using the identify method
    private func identifyUser(userKey: String) {
        guard let client = self.client else {
            print("⚠️ LaunchDarkly: Cannot identify user - client not ready")
            return
        }
        
        print("🆔 LaunchDarkly: Identifying user to LaunchDarkly: \(userKey)")
        
        // Create a user context for LaunchDarkly using the correct iOS SDK API
        // Based on the documentation example
        print("🆔 LaunchDarkly: Creating context for user: \(userKey)")
        
        let contextBuilder = LDContextBuilder(key: userKey)
        guard case .success(let context) = contextBuilder.build() else {
            print("❌ LaunchDarkly: Failed to create context for user: \(userKey)")
            return
        }
        
        print("🆔 LaunchDarkly: Successfully created context for user: \(userKey)")
        
        // Use the identify method to change the user context
        client.identify(context: context) { [weak self] in
            DispatchQueue.main.async {
                print("✅ LaunchDarkly: Successfully identified user: \(userKey)")
                
                // Force a flag re-evaluation with the new user context
                let _ = self?.boolVariation(forKey: "enhanced-product-images", defaultValue: false)
                
                // Notify observers that context changed
                self?.objectWillChange.send()
            }
        }
    }
    


   func track(event: String, properties: [String: Any] = [:]) {
        guard let client else { 
            print("LaunchDarkly: Cannot track event '\(event)' - client not initialized")
            return 
        }
        
        // Convert all properties to strings for simplicity
        var ldProperties: [String: LDValue] = [:]
        for (key, value) in properties {
            ldProperties[key] = LDValue.string("\(value)")
        }
        
        client.track(key: event, data: LDValue.object(ldProperties))
        print("LaunchDarkly: Tracked event '\(event)' with properties: \(properties)")
    }
}
