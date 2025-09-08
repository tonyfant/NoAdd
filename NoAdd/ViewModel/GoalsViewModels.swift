import Foundation

class GoalsViewModel: ObservableObject {
    @Published var recentSessions: [FocusSession] = []
    @Published var goals: [Goal] = []
    @Published var weeklyData: [DailyFocusData] = []

    init() {
        loadGoals()
        loadSessions()
        recalculateDashboard()
    }
    
    // MARK: Funzioni di Gestione Sessione
    func addSession(minutes: Int, goalId: UUID?) {
        let newSession = FocusSession(id: UUID(), durationMinutes: minutes, date: Date(), goalId: goalId)
        recentSessions.insert(newSession, at: 0)
        saveSessions()
        recalculateDashboard()
    }
    
    func deleteSession(at offsets: IndexSet) {
        recentSessions.remove(atOffsets: offsets)
        saveSessions()
        recalculateDashboard()
    }
    
    // MARK: Funzioni di Gestione Obiettivi
    func addGoal(title: String, iconName: String, targetHours: Double) {
        let newGoal = Goal(id: UUID(), title: title, iconName: iconName, targetHours: targetHours)
        goals.append(newGoal)
        saveGoals()
    }
    
    func removeGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
        saveGoals()
        recalculateDashboard()
    }
    
    // MARK: Funzione di Reset Dati
    func resetAllData() {
        // Rimuove i dati da UserDefaults
        UserDefaults.standard.removeObject(forKey: "FocusSessions")
        UserDefaults.standard.removeObject(forKey: "UserGoals")
        
        // Svuota gli array pubblicati
        recentSessions = []
        goals = []
        
        // Ricarica i dati di default (o vuoti)
        loadGoals() // Questo ricreerà gli obiettivi di default
        loadSessions() // Questo ricreerà i dati di esempio
        recalculateDashboard()
    }

    // MARK: Logica di Calcolo
    private func recalculateDashboard() {
        var tempWeeklyData: [Date: Double] = [:]
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for session in recentSessions {
            if let daysAgo = calendar.dateComponents([.day], from: session.date, to: today).day, daysAgo < 7 {
                let dayOfSession = calendar.startOfDay(for: session.date)
                tempWeeklyData[dayOfSession, default: 0] += Double(session.durationMinutes) / 60.0
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        var finalChartData: [DailyFocusData] = []
        for i in (0..<7).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let daySymbol = dateFormatter.string(from: date)
                let hours = tempWeeklyData[date] ?? 0
                finalChartData.append(DailyFocusData(day: daySymbol, date: date, hours: hours))
            }
        }
        self.weeklyData = finalChartData
        
        for i in 0..<goals.count {
            let goalId = goals[i].id
            let relevantSessions = recentSessions.filter { $0.goalId == goalId }
            let totalFocusedHoursForGoal = relevantSessions.reduce(0) { $0 + (Double($1.durationMinutes) / 60.0) }
            goals[i].currentHours = totalFocusedHoursForGoal
        }
    }

    // MARK: Funzioni di Salvataggio e Caricamento
    private func saveSessions() {
        if let encoded = try? JSONEncoder().encode(recentSessions) {
            UserDefaults.standard.set(encoded, forKey: "FocusSessions")
        }
    }
    
    private func loadSessions() {
        if let data = UserDefaults.standard.data(forKey: "FocusSessions"),
           let decoded = try? JSONDecoder().decode([FocusSession].self, from: data),
           !decoded.isEmpty {
            recentSessions = decoded
            return
        }
        createSampleData()
        saveSessions()
    }
    
    private func saveGoals() {
        if let encoded = try? JSONEncoder().encode(goals) {
            UserDefaults.standard.set(encoded, forKey: "UserGoals")
        }
    }
    
    private func loadGoals() {
        if let data = UserDefaults.standard.data(forKey: "UserGoals"),
           let decoded = try? JSONDecoder().decode([Goal].self, from: data),
           !decoded.isEmpty {
            goals = decoded
            return
        }
        goals = [
            Goal(id: UUID(), title: "Focus Settimanale", iconName: "calendar", targetHours: 10),
            Goal(id: UUID(), title: "Maestro della Produttività", iconName: "star.fill", targetHours: 50)
        ]
    }
    
    private func createSampleData() {
        var sampleSessions: [FocusSession] = []
        let calendar = Calendar.current
        let today = Date()

        guard !goals.isEmpty else { return }

        for _ in 0..<25 {
            let randomMinutes = Int.random(in: 15...90)
            let randomDayOffset = Int.random(in: 0...6)
            guard let randomDate = calendar.date(byAdding: .day, value: -randomDayOffset, to: today) else { continue }
            
            let goalId: UUID? = Double.random(in: 0...1) > 0.3 ? goals.randomElement()?.id : nil
            
            let session = FocusSession(id: UUID(), durationMinutes: randomMinutes, date: randomDate, goalId: goalId)
            sampleSessions.append(session)
        }
        
        self.recentSessions = sampleSessions.sorted(by: { $0.date > $1.date })
    }
}

