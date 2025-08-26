import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppTheme.Spacing.xl) {
                    // Header
                    VStack(spacing: AppTheme.Spacing.m) {
                        Text("LD Sport Shop")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Premium Sporting Goods & Equipment")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, AppTheme.Spacing.xl)
                    
                    // Category Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: AppTheme.Spacing.m),
                        GridItem(.flexible(), spacing: AppTheme.Spacing.m)
                    ], spacing: AppTheme.Spacing.m) {
                        
                        // Running Shoes
                        CategoryCard(
                            title: "Running Shoes",
                            subtitle: "Performance & Comfort",
                            iconName: "figure.run",
                            color: .blue,
                            destination: .productList
                        )
                        
                        // Apparel
                        CategoryCard(
                            title: "Apparel",
                            subtitle: "Active Wear & Gear",
                            iconName: "tshirt",
                            color: .green,
                            destination: .apparel
                        )
                        
                        // Equipment
                        CategoryCard(
                            title: "Equipment",
                            subtitle: "Training & Fitness",
                            iconName: "dumbbell",
                            color: .orange,
                            destination: .equipment
                        )
                        
                        // Accessories
                        CategoryCard(
                            title: "Accessories",
                            subtitle: "Essentials & More",
                            iconName: "bag",
                            color: .purple,
                            destination: .accessories
                        )
                    }
                    .padding(.horizontal, AppTheme.Spacing.l)
                    
                    // LaunchDarkly Experiment Tools (Less Prominent)
                    VStack(spacing: AppTheme.Spacing.m) {
                        Text("Experiment Tools")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                            .tracking(1)
                        
                        HStack(spacing: AppTheme.Spacing.m) {
                            // Current User Display
                            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                                Text("Current User")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text(LDService.shared.currentUserKey)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                            
                            // Random User Button (Small & Unobtrusive)
                            Button(action: {
                                LDService.shared.generateNewUserContext()
                            }) {
                                Image(systemName: "dice")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                                    .frame(width: 44, height: 44)
                                    .background(Color(.systemGray6))
                                    .clipShape(Circle())
                            }
                            .accessibilityLabel("Generate Random User")
                        }
                        .padding(.horizontal, AppTheme.Spacing.m)
                        .padding(.vertical, AppTheme.Spacing.s)
                        .background(Color(.systemGray6).opacity(0.5))
                        .cornerRadius(AppTheme.Spacing.s)
                    }
                    .padding(.horizontal, AppTheme.Spacing.l)
                    
                    Spacer(minLength: AppTheme.Spacing.xl)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CategoryCard: View {
    @EnvironmentObject private var appState: AppState
    
    let title: String
    let subtitle: String
    let iconName: String
    let color: Color
    let destination: Route
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack(spacing: AppTheme.Spacing.m) {
                // Icon
                Image(systemName: iconName)
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(color)
                    .frame(width: 60, height: 60)
                    .background(color.opacity(0.1))
                    .clipShape(Circle())
                
                // Text
                VStack(spacing: AppTheme.Spacing.xs) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(AppTheme.Spacing.l)
            .background(Color(.systemBackground))
            .cornerRadius(AppTheme.Spacing.l)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private var destinationView: some View {
        switch destination {
        case .productList:
            ProductListView(router: AppRouter(appState: appState))
        case .apparel:
            ApparelListView()
        case .equipment:
            EquipmentListView()
        case .accessories:
            AccessoriesListView()
        default:
            ProductListView(router: AppRouter(appState: appState))
        }
    }
}

struct PlaceholderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.xl) {
            Spacer()
            
            Image(systemName: "bag.circle")
                .font(.system(size: 80))
                .foregroundColor(.secondary)
            
            VStack(spacing: AppTheme.Spacing.m) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(subtitle)
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
