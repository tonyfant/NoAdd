import SwiftUI

struct GoalSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: GoalsViewModel
    var onGoalSelected: (UUID?) -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color(UIColor.systemGray3)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                List {
                    Button(action: {
                        onGoalSelected(nil)
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "brain.head.profile").foregroundColor(.white)
                            Text("Focus Generico").foregroundColor(.white)
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.1))

                    ForEach(viewModel.goals) { goal in
                        Button(action: {
                            onGoalSelected(goal.id)
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: goal.iconName).foregroundColor(.white)
                                Text(goal.title).foregroundColor(.white)
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.1))
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
                .navigationTitle("Per quale obiettivo?")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Annulla") { dismiss() }
                    }
                }
            }
        }
    }
}
