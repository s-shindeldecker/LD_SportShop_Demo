import Foundation
import LaunchDarkly

final class LDService: ObservableObject {
    static let shared = LDService()
    private init() {}
    
    @Published private(set) var isReady = false
    private var client: LDClient?
    
    func start(mobileKey: String) {
        guard client == nil else { return }
        
        let config = LDConfig(mobileKey: mobileKey, autoEnvAttributes: .init(rawValue: 0)!)
        
        // Use the old API without context for now
        LDClient.start(config: config) { [weak self] in
            self?.client = LDClient.get()
            self?.isReady = true
        }
    }
    
    func variation<T>(forKey key: String, defaultValue: T) -> T where T: LDValueConvertible, T: Decodable {
        guard let client else { return defaultValue }
        return client.variation(forKey: key, defaultValue: defaultValue)
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
