import SwiftUI

struct HomeView: View {
    let router: AppRouter
    
    var body: some View {
        List {
            Section(header: Text("Shop by Category")) {
                Button(action: {
                    router.showProductList()
                }) {
                    HStack(spacing: AppTheme.Spacing.m) {
                        Image(systemName: "figure.run").frame(width: 28, height: 28)
                        Text("Running Shoes")
                        Spacer()
                        Image(systemName: "chevron.right").foregroundStyle(.secondary)
                    }
                    .padding(.vertical, AppTheme.Spacing.s)
                }
                .buttonStyle(.plain)
            }
        }
        .listStyle(.insetGrouped)
        .background(AppTheme.Color.background)
        .accessibilityLabel("Shop by category")
    }
}

#Preview {
    HomeView(router: AppRouter(appState: AppState()))
}
