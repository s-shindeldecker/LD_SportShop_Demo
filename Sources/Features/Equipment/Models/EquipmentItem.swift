import Foundation

struct EquipmentItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let brand: String
    let category: String // e.g., "Strength", "Cardio", "Recovery"
    let price: Decimal
    let description: String
    let weight: String? // for weights
    let dimensions: String? // for equipment
    let imageName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: EquipmentItem, rhs: EquipmentItem) -> Bool {
        lhs.id == rhs.id
    }
}
