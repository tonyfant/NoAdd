import SwiftUI

struct FocusView: View {
    @EnvironmentObject var viewModel: GoalsViewModel
    @State private var selectedMinutes: Double = 25.0
    @State private var timeRemaining: TimeInterval = 0
    @State private var isTimerActive = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isShowingGoalSelection = false
    @State private var selectedGoalId: UUID? = nil
    
    // Stato per l'animazione del pulsante
    @State private var isPulsing = false

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradient()

                // La VStack principale ora ha un padding superiore per spingere
                // il contenuto sotto la notch.
                VStack(spacing: 0) {
                    
                    // Sezione Superiore: Titolo e Selettore/Countdown
                    VStack {
                        // Sostituito il titolo e mantenuto il cambio di stato
                        Text(isTimerActive ? "Concentrazione Attiva" : "NoAdd")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        TimeSelectorView(
                            selectedMinutes: $selectedMinutes,
                            timeRemaining: timeRemaining,
                            isTimerActive: isTimerActive
                        )
                    }
                    .padding(.bottom, 30)
                    
                    Spacer()
                    
                    // Sezione Centrale: Azione
                    VStack {
                        if !isTimerActive {
                            VStack(spacing: 25) {
                                VStack(spacing: 15) {
                                    Image(systemName: "waveform.path.ecg")
                                        .font(.largeTitle)
                                        .foregroundColor(.mindfulTeal)
                                    Text("Avvicina il dispositivo NFC o premi Play")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.mindfulGray)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 50)
                                }
                                
                                Button(action: { isShowingGoalSelection = true }) {
                                    Image(systemName: "play.circle.fill")
                                        .font(.system(size: 80))
                                        .foregroundColor(.white)
                                        .shadow(color: .mindfulTeal.opacity(0.5), radius: 15, x: 0, y: 0)
                                        .scaleEffect(isPulsing ? 1.1 : 1.0)
                                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isPulsing)
                                }
                            }
                        } else {
                            Button(action: toggleTimer) {
                                Text("ANNULLA")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red.opacity(0.8))
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
                            }
                            .padding(.horizontal, 40)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Spacer()

                    // Sezione Inferiore: Cronologia
                    VStack(spacing: 10) {
                        Text("Sessioni Recenti")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        if !viewModel.recentSessions.isEmpty {
                            List {
                                ForEach(viewModel.recentSessions.prefix(3)) { session in
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.mindfulTeal)
                                        Text("\(session.durationMinutes) minuti")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text(session.formattedDate)
                                            .font(.caption)
                                            .foregroundColor(.mindfulGray)
                                    }
                                    .padding(.vertical, 8)
                                    .listRowBackground(Color.glassBackground)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                        } else {
                            VStack {
                                Spacer()
                                Text("Completa una sessione per vederla qui.")
                                    .foregroundColor(.mindfulGray)
                                Spacer()
                            }
                        }
                    }
                    .frame(height: 200)
                }
                .padding(.top, 60) // Aumentato il padding per spingere più in basso
            }
            .navigationBarHidden(true)
            .onAppear {
                stopTimer() // Assicura che il timer sia fermo all'avvio
                isPulsing = true
            }
            .onReceive(timer) { _ in handleTimerTick() }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .background && isTimerActive {
                    toggleTimer()
                }
            }
            .sheet(isPresented: $isShowingGoalSelection) {
                GoalSelectionView(onGoalSelected: { goalId in
                    self.selectedGoalId = goalId
                    toggleTimer()
                })
                .environmentObject(viewModel)
            }
        }
    }
    
    private func toggleTimer() {
        if isTimerActive {
            isTimerActive = false
            timeRemaining = 0
            stopTimer()
        } else {
            timeRemaining = selectedMinutes * 60
            isTimerActive = true
            startTimer()
        }
    }
    
    private func handleTimerTick() {
        guard isTimerActive else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            viewModel.addSession(minutes: Int(selectedMinutes), goalId: selectedGoalId)
            isTimerActive = false
            stopTimer()
        }
    }

    private func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    private func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
}
