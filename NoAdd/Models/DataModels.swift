import Foundation

struct FocusSession: Identifiable, Codable, Equatable {
    let id: UUID
    let durationMinutes: Int
    let date: Date
    let goalId: UUID?

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct Goal: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var iconName: String
    var targetHours: Double
    var currentHours: Double = 0

    var progress: Double {
        guard targetHours > 0 else { return 0 }
        return min(currentHours / targetHours, 1.0)
    }

    var isCompleted: Bool {
        return currentHours >= targetHours
    }
}

struct DailyFocusData: Identifiable {
    let id = UUID()
    let day: String
    let date: Date
    var hours: Double
}
