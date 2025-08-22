import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @StateObject private var imageService = ProductImageService.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppTheme.Spacing.l) {
                // Use the image service for enhanced product images
                imageService.getProductImage(for: product, size: "detail")
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                    Text(product.brand.uppercased()).font(.footnote).foregroundStyle(.secondary)
                    Text(product.name).font(.title3).bold()
                    
                    HStack(spacing: AppTheme.Spacing.m) {
                        if let rating = product.rating { StarsView(rating: rating) }
                        Text(product.price.currencyString).font(.title3).bold()
                    }
                }
                
                Text("Lightweight, responsive cushioning for daily miles and race day. Breathable upper with locked-in midfoot.")
                    .font(.body)
                    .foregroundStyle(AppTheme.Color.textPrimary)
                
                Button("Add to Cart") {}
                    .buttonStyle(.borderedProminent)
            }
            .padding(AppTheme.Spacing.l)
        }
        .background(AppTheme.Color.background)
    }
}

private struct StarsView: View {
    let rating: Double // 0–5
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { i in
                Image(systemName: i < Int(round(rating)) ? "star.fill" : "star")
            }
        }.font(.caption).foregroundStyle(.yellow)
    }
}

#Preview {
    NavigationView {
        ProductDetailView(product: SampleProducts.all[0])
    }
}
