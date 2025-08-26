import SwiftUI

struct AccessoriesListView: View {
    private let columns = [
        GridItem(.adaptive(minimum: 160), spacing: AppTheme.Spacing.l)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.l) {
                ForEach(SampleAccessories.all) { item in
                    AccessoryCardView(item: item)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.l)
            .padding(.vertical, AppTheme.Spacing.l)
            
            Spacer(minLength: AppTheme.Spacing.xl)
        }
        .background(AppTheme.Color.background.ignoresSafeArea())
        .navigationTitle("Accessories")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationView {
        AccessoriesListView()
    }
}
