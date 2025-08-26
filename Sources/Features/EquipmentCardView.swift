import SwiftUI

struct EquipmentCardView: View {
    let item: EquipmentItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
            // Image placeholder
            Image(systemName: item.imageName)
                .font(.system(size: 40))
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Color(.systemGray6))
                .cornerRadius(AppTheme.Spacing.s)
            
            // Content
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(item.brand)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(item.price.currencyString)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                // Weight and dimensions
                if let weight = item.weight {
                    HStack {
                        Text("Weight: \(weight)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                
                if let dimensions = item.dimensions {
                    HStack {
                        Text("Size: \(dimensions)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.s)
            .padding(.bottom, AppTheme.Spacing.s)
        }
        .background(Color(.systemBackground))
        .cornerRadius(AppTheme.Spacing.m)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    EquipmentCardView(item: SampleEquipment.all[0])
        .frame(width: 200, height: 300)
        .padding()
}
