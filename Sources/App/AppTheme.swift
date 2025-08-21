import SwiftUI

enum AppTheme {
    static let COMPANY_NAME = ConfigurationService.shared.companyName
    
    enum Color {
        static let primaryGreen = SwiftUI.Color(red: 0.0, green: 0.45, blue: 0.28)
        static let background = SwiftUI.Color(.systemGroupedBackground)
        static let cardBackground = SwiftUI.Color(.secondarySystemBackground)
        static let textPrimary = SwiftUI.Color.primary
        static let textSecondary = SwiftUI.Color.secondary
    }
    
    enum Spacing {
        static let xs: CGFloat = 4, s: CGFloat = 8, m: CGFloat = 12
        static let l: CGFloat = 16, xl: CGFloat = 24, xxl: CGFloat = 32
    }
}

extension Decimal {
    var currencyString: String {
        let n = NSDecimalNumber(decimal: self)
        let f = NumberFormatter(); f.numberStyle = .currency; f.currencyCode = "USD"
        return f.string(from: n) ?? "$\(n)"
    }
}
