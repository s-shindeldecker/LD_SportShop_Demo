import SwiftUI

struct EquipmentCardView: View {
    let item: EquipmentItem
    
    var body: some View {
        NavigationLink(destination: EquipmentDetailView(item: item)) {
            VStack(spacing: AppTheme.Spacing.m) {
                // Product Image
                Image(systemName: item.imageName)
                    .font(.system(size: 40))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(Color(.systemGray6))
                    .cornerRadius(AppTheme.Spacing.s)
                
                // Product Info
                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                    Text(item.brand)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .tracking(1)
                    
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text("$\(String(format: "%.2f", item.price))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding(AppTheme.Spacing.m)
            .background(Color(.systemBackground))
            .cornerRadius(AppTheme.Spacing.m)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    EquipmentCardView(item: SampleEquipment.items[0])
}
