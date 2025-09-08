import SwiftUI

struct SettingsView: View {
    @AppStorage("endSessionNotification") private var endSessionNotification = true
    @EnvironmentObject var viewModel: GoalsViewModel
    @State private var showingResetAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradient()
                
                Form {
                    Section(header: Text("Notifiche").foregroundColor(.mindfulGray)) {
                        Toggle("Avviso a fine sessione", isOn: $endSessionNotification)
                            .tint(.mindfulTeal)
                    }
                    .listRowBackground(Color.glassBackground)
                    
                    Section(header: Text("Gestione Dati").foregroundColor(.mindfulGray)) {
                        Button(action: { showingResetAlert = true }) {
                            Label("Resetta tutti i dati", systemImage: "trash.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .listRowBackground(Color.glassBackground)

                    Section(header: Text("Altro").foregroundColor(.mindfulGray)) {
                        Link(destination: URL(string: "https://www.apple.com")!) {
                            Label("Informazioni sull'app", systemImage: "info.circle.fill")
                        }
                        
                        Link(destination: URL(string: "mailto:support@example.com")!) {
                            Label("Invia Feedback", systemImage: "envelope.fill")
                        }
                    }
                    .listRowBackground(Color.glassBackground)
                    .foregroundColor(.white)
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Impostazioni")
                .alert("Sei sicuro?", isPresented: $showingResetAlert) {
                    Button("Annulla", role: .cancel) { }
                    Button("Resetta", role: .destructive) { viewModel.resetAllData() }
                } message: {
                    Text("Questa azione eliminerà permanentemente tutte le sessioni e gli obiettivi.")
                }
            }
        }
    }
}
