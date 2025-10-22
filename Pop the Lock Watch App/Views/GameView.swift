//
//  GameView.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        ZStack {
            // Make entire screen tappable
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    gameState.tapToPop()
                }
            
            VStack(spacing: 8) {
                // Score and Level
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Score: \(gameState.score)/\(gameState.targetScore)")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text(gameState.currentMode.rawValue)
                            .font(.caption2)
                            .foregroundColor(gameState.currentMode.color)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Level \(gameState.currentLevel)")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text("Tap to Pop!")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                // Game Area - Lock Design
                LockGameArea(gameState: gameState)
            }
        }
    }
}

struct LockGameArea: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        ZStack {
            // Outer glow effect
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .frame(width: 130, height: 130)
                .blur(radius: 1)
            
            // Lock circle - white
            Circle()
                .stroke(Color.white, lineWidth: 4)
                .frame(width: 120, height: 120)
            
            // Target zone with glow
            Circle()
                .trim(from: (gameState.targetZone - 15) / 360, 
                      to: (gameState.targetZone + 15) / 360)
                .stroke(
                    LinearGradient(
                        colors: [.green, .green.opacity(0.6)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 8
                )
                .frame(width: 120, height: 120)
                .rotationEffect(.degrees(-90))
                .shadow(color: .green.opacity(0.5), radius: 3)
            
            // Rotating line with glow - orange
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.red, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 3, height: 60)
                .offset(y: -30)
                .rotationEffect(.degrees(gameState.lockRotation))
                .shadow(color: .red.opacity(0.5), radius: 2)
            
            // Center dot with glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [.white, .gray.opacity(0.8)],
                        center: .center,
                        startRadius: 0,
                        endRadius: 4
                    )
                )
                .frame(width: 10, height: 10)
                .shadow(color: .white.opacity(0.5), radius: 2)
            
            // Current score inside lock (starts at 0, increases to level number)
            Text("\(gameState.score)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 1)
        }
    }
}


#Preview {
    GameView(gameState: GameState())
}

