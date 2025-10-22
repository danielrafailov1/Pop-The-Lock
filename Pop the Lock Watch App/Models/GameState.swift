//
//  GameState.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import SwiftUI
import Combine
import WatchKit

class GameState: ObservableObject {
    @Published var score = 0
    @Published var currentLevel = 1
    @Published var currentMode: GameMode = .superEasy
    @Published var gameStatus: GameStatus = .modeSelect
    @Published var lockRotation: Double = 0
    @Published var targetZone: Double = 0
    @Published var lockSpeed: Double = 1.0
    @Published var isInTargetZone = false
    @Published var rotationDirection: Double = 1.0
    @Published var targetScore = 5
    @Published var completedLevels: Set<String> = []
    
    private var timer: Timer?
    private var progressManager = ProgressManager()
    private var gameStartTime: Date?
    
    enum GameStatus {
        case modeSelect, levelSelect, playing, gameOver, levelComplete, modeComplete
    }
    
    enum GameMode: String, CaseIterable {
        case superEasy = "Super Easy"
        case easy = "Easy"
        case medium = "Medium"
        case advanced = "Advanced"
        case hard = "Hard"
        case expert = "Expert"
        
        var color: Color {
            switch self {
            case .superEasy: return .green
            case .easy: return .blue
            case .medium: return .yellow
            case .advanced: return .orange
            case .hard: return .red
            case .expert: return .purple
            }
        }
        
        var baseSpeed: Double {
            switch self {
            case .superEasy: return 0.5
            case .easy: return 0.8
            case .medium: return 1.2
            case .advanced: return 1.6
            case .hard: return 2.0
            case .expert: return 2.5
            }
        }
        
        var speedIncrease: Double {
            switch self {
            case .superEasy: return 0.03
            case .easy: return 0.05
            case .medium: return 0.08
            case .advanced: return 0.1
            case .hard: return 0.12
            case .expert: return 0.15
            }
        }
    }
    
    init() {
        // ProgressManager handles loading automatically
    }
    
    // MARK: - Game Control Methods
    
    func startGame(mode: GameMode, level: Int) {
        gameStatus = .playing
        score = 0
        currentLevel = level
        currentMode = mode
        lockSpeed = mode.baseSpeed
        rotationDirection = 1.0
        targetScore = calculateTargetScore(mode: mode, level: level)
        gameStartTime = Date()
        startLockRotation()
    }
    
    func tapToPop() {
        if isInTargetZone {
            // Success!
            score += 1
            
            // Alternate direction on every tap
            rotationDirection *= -1.0
            
            // Increase speed based on mode
            lockSpeed = min(lockSpeed + currentMode.speedIncrease, currentMode.baseSpeed * 2.5)
            
            // Haptic feedback
            WKInterfaceDevice.current().play(.success)
            
            // Check if level is completed
            if score >= targetScore {
                completeLevel()
            } else {
                // Generate new target zone
                targetZone = Double.random(in: 0...360)
            }
        } else {
            // Game over
            gameStatus = .gameOver
            timer?.invalidate()
            progressManager.resetStreak()
            WKInterfaceDevice.current().play(.failure)
        }
    }
    
    func resetGame() {
        timer?.invalidate()
        gameStatus = .modeSelect
    }
    
    func selectMode(_ mode: GameMode) {
        currentMode = mode
        gameStatus = .levelSelect
    }
    
    func playNextLevel() {
        if currentLevel < 50 {
            startGame(mode: currentMode, level: currentLevel + 1)
        } else {
            gameStatus = .modeComplete
        }
    }
    
    func returnToLevelSelect() {
        gameStatus = .levelSelect
    }
    
    // MARK: - Private Methods
    
    private func startLockRotation() {
        timer?.invalidate()
        lockRotation = 0
        targetZone = Double.random(in: 0...360)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            self.lockRotation += self.lockSpeed * self.rotationDirection
            if self.lockRotation >= 360 {
                self.lockRotation = 0
            } else if self.lockRotation < 0 {
                self.lockRotation = 360
            }
            
            // Check if in target zone (30 degree tolerance)
            let diff = abs(self.lockRotation - self.targetZone)
            self.isInTargetZone = diff <= 15 || diff >= 345
        }
    }
    
    private func completeLevel() {
        timer?.invalidate()
        
        // Update progress using ProgressManager
        progressManager.completeLevel(mode: currentMode.rawValue, level: currentLevel)
        
        // Update game statistics
        if let startTime = gameStartTime {
            let playTime = Date().timeIntervalSince(startTime)
            progressManager.updateGameStats(score: score, playTime: playTime)
        }
        
        // Update local completed levels for UI
        let levelKey = getLevelKey(mode: currentMode, level: currentLevel)
        completedLevels.insert(levelKey)
        
        // Check if all levels in mode are completed
        let allLevelsCompleted = (1...50).allSatisfy { level in
            progressManager.isLevelCompleted(mode: currentMode.rawValue, level: level)
        }
        
        if allLevelsCompleted {
            gameStatus = .modeComplete
        } else {
            gameStatus = .levelComplete
        }
        
        WKInterfaceDevice.current().play(.success)
    }
    
    private func calculateTargetScore(mode: GameMode, level: Int) -> Int {
        // Target score is simply the level number
        return level
    }
    
    private func getLevelKey(mode: GameMode, level: Int) -> String {
        return "\(mode.rawValue)_\(level)"
    }
    
    // MARK: - Progress Management
    
    func isLevelCompleted(mode: GameMode, level: Int) -> Bool {
        return progressManager.isLevelCompleted(mode: mode.rawValue, level: level)
    }
    
    // MARK: - Statistics Access
    
    func getProgressManager() -> ProgressManager {
        return progressManager
    }
}
