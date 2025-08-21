import SwiftUI

struct ProductCardView: View {
    let product: Product
    let onTap: (Product) -> Void
    
    var body: some View {
        Button(action: { onTap(product) }) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.Color.cardBackground)
                    .shadow(radius: 1, y: 1)
                
                VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                    Image(systemName: product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .padding(.top, AppTheme.Spacing.l)
                    
                    Text(product.brand.uppercased())
                        .font(.footnote)
                        .foregroundStyle(AppTheme.Color.textSecondary)
                    
                    Text(product.name)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.Color.textPrimary)
                        .lineLimit(2)
                    
                    Text(product.price.currencyString)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(AppTheme.Color.textPrimary)
                }
                .padding(AppTheme.Spacing.l)
                
                if let badge = product.badgeText ?? (product.isNew ? "New" : nil) {
                    Text(badge)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.Color.primaryGreen.opacity(0.15))
                        .cornerRadius(8)
                        .padding(AppTheme.Spacing.s)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(product.name), \(product.price.currencyString)")
    }
}

#Preview {
    ProductCardView(
        product: SampleProducts.all[0]
    ) { product in
        print("Product tapped: \(product.name)")
    }
    .frame(width: 180)
    .padding()
}
