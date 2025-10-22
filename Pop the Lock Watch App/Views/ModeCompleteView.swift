//
//  ModeCompleteView.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI

struct ModeCompleteView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Mode Cleared!")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
                .shadow(color: .yellow.opacity(0.5), radius: 2)
            
            VStack(spacing: 8) {
                Text("🎉 \(gameState.currentMode.rawValue) 🎉")
                    .font(.title3)
                    .foregroundColor(gameState.currentMode.color)
                
                Text("All 50 levels completed!")
                    .font(.body)
                    .foregroundColor(.white)
            }
            
            Button("Choose Mode") {
                gameState.resetGame()
            }
            .buttonStyle(.borderedProminent)
            .tint(.yellow)
            .controlSize(.large)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.yellow.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ModeCompleteView(gameState: GameState())
}
