import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var viewModel: GoalsViewModel
    @State private var isShowingAddGoal = false

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradient()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Dashboard")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top)

                        WeeklyFocusChartView()
                            .padding(.horizontal)
                        
                        Text("I Tuoi Obiettivi")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ForEach(viewModel.goals) { goal in
                            GoalCardView(goal: goal)
                                .padding(.horizontal)
                        }
                        .onDelete(perform: viewModel.removeGoal)
                        
                    }
                }
            }
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddGoal = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.mindfulTeal)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddGoal) {
                AddGoalView().environmentObject(viewModel)
            }
        }
    }
}

