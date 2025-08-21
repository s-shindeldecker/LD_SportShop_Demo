import Foundation

struct Product: Identifiable, Hashable {
    let id: UUID
    let name: String
    let brand: String
    let price: Decimal
    let imageName: String
    let rating: Double?
    let isNew: Bool
    let badgeText: String?
    
    init(id: UUID = UUID(), name: String, brand: String, price: Decimal, imageName: String = "shoe", rating: Double? = nil, isNew: Bool = false, badgeText: String? = nil) {
        self.id = id; self.name = name; self.brand = brand; self.price = price; self.imageName = imageName; self.rating = rating; self.isNew = isNew; self.badgeText = badgeText
    }
}
