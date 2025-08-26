import SwiftUI

struct EquipmentDetailView: View {
    let item: EquipmentItem
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.l) {
                // Product Image
                Image(systemName: item.imageName)
                    .font(.system(size: 120))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .background(Color(.systemGray6))
                    .cornerRadius(AppTheme.Spacing.m)
                
                VStack(alignment: .leading, spacing: AppTheme.Spacing.m) {
                    // Product Info
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                        Text(item.brand)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                            .tracking(1)
                        
                        Text(item.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("$\(String(format: "%.2f", item.price))")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    
                    Divider()
                    
                    // Description
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                        Text("Description")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    
                    Divider()
                    
                    // Specifications
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                        Text("Specifications")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            SpecRow(label: "Weight", value: "2.5 lbs")
                            SpecRow(label: "Material", value: "High-grade steel")
                            SpecRow(label: "Dimensions", value: "12\" x 8\" x 4\"")
                            SpecRow(label: "Warranty", value: "2 years")
                        }
                    }
                    
                    Divider()
                    
                    // Features
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                        Text("Features")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            FeatureRow(text: "Professional grade quality")
                            FeatureRow(text: "Ergonomic design")
                            FeatureRow(text: "Non-slip grip")
                            FeatureRow(text: "Easy to maintain")
                        }
                    }
                    
                    Divider()
                    
                    // Add to Cart Button
                    Button(action: {
                        // TODO: Implement add to cart functionality
                    }) {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                                .font(.title2)
                            Text("Add to Cart")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(AppTheme.Spacing.s)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, AppTheme.Spacing.l)
            }
            .padding(.vertical, AppTheme.Spacing.l)
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.large)
        .background(AppTheme.Color.background)
    }
}

struct SpecRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        EquipmentDetailView(item: SampleEquipment.items[0])
    }
    .environmentObject(AppState())
}
