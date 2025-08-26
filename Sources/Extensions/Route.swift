import Foundation

enum Route: Hashable {
    case catalog
    case apparel
    case equipment
    case accessories
    case productList
    case product(Product)
}
