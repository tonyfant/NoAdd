import SwiftUI

struct GoalCardView: View {
    let goal: Goal

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: goal.iconName)
                    .font(.title)
                    .foregroundColor(.mindfulTeal)
                Text(goal.title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
                if goal.isCompleted {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.mindfulTeal)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                ProgressView(value: goal.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .mindfulTeal))
                
                HStack {
                    Text("\(goal.currentHours, specifier: "%.1f") / \(goal.targetHours, specifier: "%.0f") ore")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.mindfulGray)
                    Spacer()
                    Text("\(Int(goal.progress * 100))%")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.mindfulTeal)
                }
            }
        }
        .padding()
        .background(Color.glassBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}
