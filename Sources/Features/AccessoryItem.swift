import Foundation

struct AccessoryItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let brand: String
    let category: String // e.g., "Bags", "Electronics", "Nutrition"
    let price: Decimal
    let description: String
    let material: String?
    let imageName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AccessoryItem, rhs: AccessoryItem) -> Bool {
        lhs.id == rhs.id
    }
}
