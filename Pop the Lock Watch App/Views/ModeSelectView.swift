//
//  ModeSelectView.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI

struct ModeSelectView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Pop the Lock")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                
                Text("Choose Your Mode")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 4)
                
                ForEach(GameState.GameMode.allCases, id: \.self) { mode in
                    ModeButton(mode: mode, gameState: gameState)
                }
            }
            .padding()
        }
    }
}

struct ModeButton: View {
    let mode: GameState.GameMode
    @ObservedObject var gameState: GameState
    
    var body: some View {
        Button(action: {
            gameState.selectMode(mode)
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(mode.rawValue)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("\(gameState.getProgressManager().getCompletedLevelsCount(for: mode.rawValue))/50")
                            .font(.caption)
                            .foregroundColor(mode.color)
                            .fontWeight(.medium)
                    }
                    
                    Text("Speed: \(String(format: "%.1f", mode.baseSpeed))x")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(mode.color)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(mode.color.opacity(0.7), lineWidth: 2)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ModeSelectView(gameState: GameState())
}
