import SwiftUI

struct ApparelListView: View {
    private let columns = [
        GridItem(.adaptive(minimum: 160), spacing: AppTheme.Spacing.l)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.l) {
                ForEach(SampleApparel.all) { item in
                    ApparelCardView(item: item)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.l)
            .padding(.vertical, AppTheme.Spacing.l)
            
            Spacer(minLength: AppTheme.Spacing.xl)
        }
        .background(AppTheme.Color.background.ignoresSafeArea())
        .navigationTitle("Apparel")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationView {
        ApparelListView()
    }
}
