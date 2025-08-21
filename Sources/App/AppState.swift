import SwiftUI

final class AppState: ObservableObject {
    @Published var path: [Route] = []
    @Published var selectedProduct: Product?
}
