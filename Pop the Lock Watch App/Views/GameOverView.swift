//
//  GameOverView.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Game Over")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .shadow(color: .red.opacity(0.5), radius: 2)
            
            VStack(spacing: 8) {
                Text("Score: \(gameState.score)/\(gameState.targetScore)")
                    .font(.title3)
                    .foregroundColor(.white)
                
                Text("Mode: \(gameState.currentMode.rawValue)")
                    .font(.body)
                    .foregroundColor(gameState.currentMode.color)
                
                Text("Level: \(gameState.currentLevel)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 10) {
                Button("Retry Level") {
                    gameState.startGame(mode: gameState.currentMode, level: gameState.currentLevel)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .controlSize(.large)
                
                Button("Select Level") {
                    gameState.resetGame()
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
                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    GameOverView(gameState: GameState())
}
