//
//  ContentView.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    
    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            
            // Main game router
            Group {
                switch gameState.gameStatus {
                case .modeSelect:
                    ModeSelectView(gameState: gameState)
                case .levelSelect:
                    LevelSelectView(gameState: gameState)
                case .playing:
                    GameView(gameState: gameState)
                case .gameOver:
                    GameOverView(gameState: gameState)
                case .levelComplete:
                    LevelCompleteView(gameState: gameState)
                case .modeComplete:
                    ModeCompleteView(gameState: gameState)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
