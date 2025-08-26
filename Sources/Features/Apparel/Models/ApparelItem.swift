import Foundation

struct ApparelItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let brand: String
    let category: String // e.g., "Running", "Training", "Casual"
    let price: Decimal
    let description: String
    let sizes: [String]
    let colors: [String]
    let imageName: String // SF Symbol name for now
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ApparelItem, rhs: ApparelItem) -> Bool {
        lhs.id == rhs.id
    }
}
