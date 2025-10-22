//
//  LevelCompleteView.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI

struct LevelCompleteView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Level Complete!")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .shadow(color: .green.opacity(0.5), radius: 2)
            
            VStack(spacing: 8) {
                Text("Score: \(gameState.score)/\(gameState.targetScore)")
                    .font(.title3)
                    .foregroundColor(.white)
                
                Text("\(gameState.currentMode.rawValue) - Level \(gameState.currentLevel)")
                    .font(.body)
                    .foregroundColor(gameState.currentMode.color)
            }
            
            VStack(spacing: 10) {
                if gameState.currentLevel < 50 {
                    Button("Next Level") {
                        gameState.playNextLevel()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .controlSize(.large)
                }
                
                Button("Level Select") {
                    gameState.returnToLevelSelect()
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                .controlSize(.regular)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.green.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    LevelCompleteView(gameState: GameState())
}
