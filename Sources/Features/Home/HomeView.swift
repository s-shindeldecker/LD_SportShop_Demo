import SwiftUI

struct HomeView: View {
    let router: AppRouter
    @StateObject private var ldService = LDService.shared
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: AppTheme.Spacing.l) {
                // Shop by Category Section
                VStack(alignment: .leading, spacing: AppTheme.Spacing.m) {
                    Text("Shop by Category")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.Color.primaryGreen)
                    
                    Button(action: {
                        router.showProductList()
                    }) {
                        HStack(spacing: AppTheme.Spacing.m) {
                            Image(systemName: "figure.run").frame(width: 28, height: 28)
                            Text("Running Shoes")
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(.secondary)
                        }
                        .padding(.vertical, AppTheme.Spacing.s)
                        .padding(.horizontal, AppTheme.Spacing.m)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, AppTheme.Spacing.m)
                
                // LaunchDarkly Experiment Tools Section
                VStack(alignment: .leading, spacing: AppTheme.Spacing.m) {
                    Text("🧪 LaunchDarkly Experiment Tools")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.Color.primaryGreen)
                    
                    VStack(spacing: AppTheme.Spacing.m) {
                        // Current User Display
                        HStack {
                            Text("Current User:")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(ldService.currentUserKey)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(AppTheme.Color.primaryGreen)
                        }
                        .padding(.horizontal, AppTheme.Spacing.m)
                        .padding(.vertical, AppTheme.Spacing.s)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                        // Generate Random User Button
                        Button(action: {
                            ldService.generateNewUserContext()
                        }) {
                            Text("🎲 Generate Random User")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, AppTheme.Spacing.m)
                        
                        Text("Click to generate a completely new random user ID for LaunchDarkly experiments")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.m)
                        
                        // Predefined Users Section
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                            Text("Or pick a specific user:")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, AppTheme.Spacing.m)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: AppTheme.Spacing.s) {
                                ForEach(ldService.predefinedUsers, id: \.self) { userKey in
                                    Button(action: {
                                        ldService.switchToUser(userKey: userKey)
                                    }) {
                                        Text(userKey.suffix(3))
                                            .font(.caption2)
                                            .fontWeight(.medium)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(userKey == ldService.currentUserKey ? AppTheme.Color.primaryGreen : AppTheme.Color.primaryGreen.opacity(0.1))
                                            .foregroundStyle(userKey == ldService.currentUserKey ? .white : AppTheme.Color.primaryGreen)
                                            .cornerRadius(6)
                                    }
                                    .buttonStyle(.plain)
                                    .disabled(!ldService.isReady)
                                }
                            }
                            .padding(.horizontal, AppTheme.Spacing.m)
                        }
                        
                        Text("Each user gets a fresh LaunchDarkly context for experiments")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.m)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.m)
                
                // Add some bottom padding to ensure content doesn't get cut off
                Spacer(minLength: AppTheme.Spacing.xl)
            }
        }
        .background(AppTheme.Color.background)
        .accessibilityLabel("Shop by category")
    }
}

#Preview {
    HomeView(router: AppRouter(appState: AppState()))
}
