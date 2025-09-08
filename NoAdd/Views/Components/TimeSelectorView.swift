import SwiftUI

struct TimeSelectorView: View {
    @Binding var selectedMinutes: Double
    let timeRemaining: TimeInterval
    let isTimerActive: Bool
    
    private let timeOptions: [Double] = [5, 15, 25, 45, 60, 90]

    private func formatTime(interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack(spacing: 25) {
            // Display centrale
            ZStack {
                Circle()
                    .stroke(Color.glassBackground, lineWidth: 5)
                
                if isTimerActive {
                    Text(formatTime(interval: timeRemaining))
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .contentTransition(.numericText(countsDown: true))
                } else {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("\(Int(selectedMinutes))")
                            .font(.system(size: 70, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .contentTransition(.numericText())
                        Text("min")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                            .foregroundColor(.mindfulGray)
                    }
                }
            }
            .frame(width: 220, height: 220)
            .animation(.easeInOut, value: isTimerActive)
            
            // Pulsanti di selezione
            if !isTimerActive {
                HStack(spacing: 12) {
                    ForEach(timeOptions, id: \.self) { minutes in
                        Button(action: { selectedMinutes = minutes }) {
                            Text("\(Int(minutes))")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(selectedMinutes == minutes ? .mindfulBlack : .white)
                                .frame(width: 55, height: 40)
                                .background(selectedMinutes == minutes ? Color.mindfulTeal : Color.glassBackground)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(selectedMinutes == minutes ? Color.clear : Color.mindfulGray, lineWidth: 1)
                                )
                        }
                    }
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: selectedMinutes)
        .animation(.easeInOut, value: isTimerActive)
        .padding(.top, 20)
    }
}
