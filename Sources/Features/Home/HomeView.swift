import SwiftUI

struct HomeView: View {
    let router: AppRouter
    @StateObject private var ldService = LDService.shared
    
    var body: some View {
        List {
            Section(header: Text("Shop by Category")) {
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
                }
                .buttonStyle(.plain)
            }
            
                                Section(header: Text("LaunchDarkly Experiment Tools")) {
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.s) {
                            HStack {
                                Text("Current User:")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(ldService.currentUserKey)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(AppTheme.Color.primaryGreen)
                            }
                            
                            Button(action: {
                                ldService.generateNewUserContext()
                            }) {
                                HStack(spacing: AppTheme.Spacing.s) {
                                    Image(systemName: "person.badge.plus")
                                        .foregroundStyle(AppTheme.Color.primaryGreen)
                                    Text("Switch to Random User")
                                        .fontWeight(.medium)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, AppTheme.Spacing.s)
                                .background(AppTheme.Color.primaryGreen.opacity(0.1))
                                .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                            .disabled(!ldService.isReady)
                            
                            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                                Text("Or pick a specific user:")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: AppTheme.Spacing.xs) {
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
                            }
                            
                            Text("Each user gets a fresh LaunchDarkly context for experiments")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, AppTheme.Spacing.xs)
                    }
        }
        .listStyle(.sidebar)
        .background(AppTheme.Color.background)
        .accessibilityLabel("Shop by category")
    }
}

#Preview {
    HomeView(router: AppRouter(appState: AppState()))
}
