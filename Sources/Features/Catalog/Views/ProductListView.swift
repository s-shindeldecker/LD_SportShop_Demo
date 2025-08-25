import SwiftUI

struct ProductListView: View {
    let router: AppRouter
    private let columns = [GridItem(.adaptive(minimum: 160), spacing: AppTheme.Spacing.l)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.l) {
                ForEach(SampleProducts.all) { product in
                    ProductCardView(product: product) { tapped in
                        router.showProduct(tapped, from: "product_list")
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.l)
            .padding(.vertical, AppTheme.Spacing.l)
            
            // Add extra bottom padding to ensure all content is scrollable
            Spacer(minLength: AppTheme.Spacing.xl)
        }
        .background(AppTheme.Color.background.ignoresSafeArea())
        .navigationTitle("Running Shoes")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationView {
        ProductListView(router: AppRouter(appState: AppState()))
    }
}
