import SwiftUI

struct ApparelCardView: View {
    let item: ApparelItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
            // Image placeholder
            Image(systemName: item.imageName)
                .font(.system(size: 40))
                .foregroundColor(.green)
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
                    .foregroundColor(.green)
                
                // Sizes and colors
                HStack {
                    Text("Sizes: \(item.sizes.joined(separator: ", "))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
                HStack {
                    Text("Colors: \(item.colors.joined(separator: ", "))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Spacer()
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
    ApparelCardView(item: SampleApparel.all[0])
        .frame(width: 200, height: 300)
        .padding()
}
