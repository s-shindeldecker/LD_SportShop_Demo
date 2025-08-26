import SwiftUI

struct EquipmentListView: View {
    private let columns = [
        GridItem(.adaptive(minimum: 160), spacing: AppTheme.Spacing.l)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.l) {
                ForEach(SampleEquipment.all) { item in
                    EquipmentCardView(item: item)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.l)
            .padding(.vertical, AppTheme.Spacing.l)
            
            Spacer(minLength: AppTheme.Spacing.xl)
        }
        .background(AppTheme.Color.background.ignoresSafeArea())
        .navigationTitle("Equipment")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationView {
        EquipmentListView()
    }
}
