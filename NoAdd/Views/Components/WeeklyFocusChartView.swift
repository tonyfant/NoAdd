import SwiftUI
import Charts

struct WeeklyFocusChartView: View {
    @EnvironmentObject var viewModel: GoalsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Attività Settimanale")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(viewModel.weeklyData.reduce(0, { $0 + $1.hours }), specifier: "%.1f") ore totali")
                        .font(.subheadline)
                        .foregroundColor(.mindfulGray)
                }
                Spacer()
            }
            
            Chart(viewModel.weeklyData) { data in
                BarMark(
                    x: .value("Giorno", data.day),
                    y: .value("Ore", data.hours)
                )
                .foregroundStyle(
                    LinearGradient(colors: [.mindfulTeal.opacity(0.4), .mindfulTeal], startPoint: .bottom, endPoint: .top)
                )
                .cornerRadius(8)
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine(stroke: StrokeStyle(dash: [3, 3])).foregroundStyle(Color.mindfulGray)
                    AxisValueLabel {
                        if let hours = value.as(Double.self) {
                            Text("\(hours, specifier: "%.1f")h")
                                .font(.caption)
                                .foregroundColor(.mindfulGray)
                        }
                    }
                }
            }
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel {
                        if let day = value.as(String.self) {
                            Text(day)
                                .font(.caption)
                                .foregroundColor(.mindfulGray)
                        }
                    }
                }
            }
            .frame(height: 180)
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

