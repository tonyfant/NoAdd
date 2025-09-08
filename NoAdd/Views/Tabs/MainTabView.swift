import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel = GoalsViewModel()

    init() {
        // Personalizziamo l'aspetto della TabBar per adattarla al nuovo design
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.mindfulBlack.opacity(0.8))
        
        // Colore dell'icona non selezionata
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.mindfulGray)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.mindfulGray)]
        
        // Colore dell'icona selezionata
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.mindfulTeal)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.mindfulTeal)]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            FocusView()
                .tabItem {
                    Label("Focus", systemImage: "hourglass")
                }
            
            GoalsView()
                .tabItem {
                    Label("Obiettivi", systemImage: "target")
                }
            
            SettingsView()
                .tabItem {
                    Label("Impostazioni", systemImage: "gearshape.fill")
                }
        }
        .environmentObject(viewModel)
        .accentColor(.mindfulTeal) // Imposta il colore di accento per tutta l'app
    }
}

