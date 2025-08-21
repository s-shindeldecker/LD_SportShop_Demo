import Foundation

final class AnalyticsService {
    static let shared = AnalyticsService()
    private init() {}
    
    func track(event: String, props: [String: Any] = [:]) {
        #if DEBUG
        print("[Analytics] event=\(event) props=\(props)")
        #endif
    }
}
