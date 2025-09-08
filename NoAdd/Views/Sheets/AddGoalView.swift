import SwiftUI

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: GoalsViewModel
    
    @State private var title: String = ""
    @State private var targetHours: String = ""
    @State private var selectedIcon: String = "star.fill"
    
    let icons = ["calendar", "star.fill", "briefcase.fill", "book.fill", "desktopcomputer", "graduationcap.fill", "pencil.and.ruler.fill"]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color(UIColor.systemGray3)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                formContent
            }
            .navigationTitle("Nuovo Obiettivo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salva") {
                        guard let hours = Double(targetHours), !title.isEmpty else { return }
                        viewModel.addGoal(title: title, iconName: selectedIcon, targetHours: hours)
                        dismiss()
                    }
                    .disabled(title.isEmpty || targetHours.isEmpty)
                }
            }
        }
    }
    
    private var formContent: some View {
        Form {
            Section(header: Text("Dettagli Obiettivo").foregroundColor(.gray)) {
                TextField("Nome dell'obiettivo", text: $title)
                TextField("Ore totali richieste", text: $targetHours)
                    .keyboardType(.decimalPad)
            }
            .listRowBackground(Color.white.opacity(0.1))
            
            Section(header: Text("Scegli un'icona").foregroundColor(.gray)) {
                iconSelector
            }
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
    }
    
    private var iconSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(icons, id: \.self) { icon in
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(selectedIcon == icon ? .blue : .white)
                        .padding()
                        .background(Color.white.opacity(selectedIcon == icon ? 0.3 : 0.1))
                        .clipShape(Circle())
                        .onTapGesture { selectedIcon = icon }
                }
            }
            .padding(.vertical)
        }
    }
}

