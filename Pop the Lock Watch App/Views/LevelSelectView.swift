//
//  LevelSelectView.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI

struct LevelSelectView: View {
    @ObservedObject var gameState: GameState
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 5)
    
    var body: some View {
        VStack(spacing: 8) {
            // Header
            HStack {
                Button("←") {
                    gameState.gameStatus = .modeSelect
                }
                .font(.caption2)
                .foregroundColor(.blue)
                .frame(width: 30)
                
                Spacer()
                
                Text(gameState.currentMode.rawValue)
                    .font(.caption)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Spacer()
                
                Text("\(String(format: "%.1f", gameState.currentMode.baseSpeed))x")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .frame(width: 30)
            }
            .padding(.horizontal)
            
            // Level Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(1...50, id: \.self) { level in
                        LevelGridButton(level: level, mode: gameState.currentMode, gameState: gameState)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct LevelGridButton: View {
    let level: Int
    let mode: GameState.GameMode
    @ObservedObject var gameState: GameState
    
    private var isCompleted: Bool {
        gameState.isLevelCompleted(mode: mode, level: level)
    }
    
    var body: some View {
        Button(action: {
            gameState.startGame(mode: mode, level: level)
        }) {
            ZStack {
                Text("\(level)")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(isCompleted ? mode.color.opacity(0.3) : Color.gray.opacity(0.3))
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(mode.color.opacity(0.8), lineWidth: 1.5)
                            )
                    )
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.caption2)
                        .foregroundColor(mode.color)
                        .fontWeight(.bold)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LevelSelectView(gameState: GameState())
}

