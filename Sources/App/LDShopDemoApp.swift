import SwiftUI

@main
struct LDShopDemoApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .task {
                    // TODO: Replace with your actual LaunchDarkly mobile key
                    // You can get this from your LaunchDarkly dashboard under Settings > Keys
                    // For development, you can also set this via environment variables or configuration
                    LDService.shared.start(mobileKey: "YOUR_MOBILE_KEY")
                }
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationStack(path: $appState.path) {
            HomeView(router: AppRouter(appState: appState))
                .navigationTitle(AppTheme.COMPANY_NAME)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(AppTheme.Color.primaryGreen, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .background(AppTheme.Color.background)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .productList:
                        ProductListView(router: AppRouter(appState: appState))
                    case .product(let product):
                        ProductDetailView(product: product)
                    }
                }
        }
    }
}
