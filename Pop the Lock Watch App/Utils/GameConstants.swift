//
//  GameConstants.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import Foundation

struct GameConstants {
    // Game Configuration
    static let totalLevelsPerMode = 50
    static let targetTolerance = 15.0 // degrees
    static let timerInterval = 0.016 // 60 FPS
    static let maxSpeedMultiplier = 2.5
    
    // Storage Keys
    static let completedLevelsKey = "completedLevels"
    
    // Visual Constants
    static let lockSize: CGFloat = 120
    static let innerRingSize: CGFloat = 100
    static let yellowBallSize: CGFloat = 12
    static let rotatingLineWidth: CGFloat = 4
    static let rotatingLineHeight: CGFloat = 50
    static let levelGridColumns = 5
    static let levelButtonSize: CGFloat = 30
}
