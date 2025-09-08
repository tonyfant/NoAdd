//
//  Color+Extension.swift
//  NoAdd
//
//  Created by Anthony Fantin on 07/09/25.
//

import SwiftUI

// Definiamo la nostra palette di colori personalizzata per un accesso facile e coerente
extension Color {
    static let mindfulBlack = Color(red: 0.08, green: 0.09, blue: 0.1)
    static let mindfulTeal = Color(red: 0.2, green: 0.8, blue: 0.7)
    static let mindfulGray = Color(white: 0.5)
    static let glassBackground = Color.white.opacity(0.08)
}

// Un gradiente di sfondo riutilizzabile per tutta l'app
struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.mindfulBlack, Color.black]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}
