import SwiftUI

struct ProductListView: View {
    let router: AppRouter
    private let columns = [GridItem(.adaptive(minimum: 160), spacing: AppTheme.Spacing.l)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.l) {
                ForEach(SampleProducts.all) { product in
                    ProductCardView(product: product) { tapped in
                        router.showProduct(tapped, from: "product_list")
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.l)
            .padding(.vertical, AppTheme.Spacing.l)
        }
        .background(AppTheme.Color.background.ignoresSafeArea())
        .navigationTitle("Running Shoes")
    }
}

#Preview {
    NavigationView {
        ProductListView(router: AppRouter(appState: AppState()))
    }
}
