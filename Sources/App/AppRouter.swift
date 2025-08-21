import Foundation

final class AppRouter {
    unowned let appState: AppState
    
    init(appState: AppState) { 
        self.appState = appState 
    }
    
    func showProductList() {
        appState.path.append(.productList)
        AnalyticsService.shared.track(event: "product_list_navigation", props: [
            "source": "home"
        ])
    }
    
    func showProduct(_ product: Product, from source: String? = nil) {
        appState.selectedProduct = product
        appState.path.append(.product(product))
        AnalyticsService.shared.track(event: "product_card_tap", props: [
            "id": product.id.uuidString,
            "name": product.name,
            "brand": product.brand,
            "source": source ?? "list"
        ])
            // LaunchDarkly tracking
    LDService.shared.track(event: "product_selected", properties: [
        "product_id": product.id.uuidString,
        "product_name": product.name,
        "product_brand": product.brand,
        "product_price": product.price.description,
        "source": source ?? "list"
    ])
    }
}
