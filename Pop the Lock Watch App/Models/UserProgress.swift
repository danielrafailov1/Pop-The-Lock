//
//  UserProgress.swift
//  Pop the Lock Watch App
//
//  Created by Daniel Rafailov on 2025-10-22.
//

import Foundation
import Combine

struct UserProgress: Codable {
    var completedLevels: Set<String>
    var totalScore: Int
    var totalGamesPlayed: Int
    var bestStreak: Int
    var currentStreak: Int
    var lastPlayedDate: Date
    var favoriteMode: String?
    var totalPlayTime: TimeInterval
    
    init() {
        self.completedLevels = []
        self.totalScore = 0
        self.totalGamesPlayed = 0
        self.bestStreak = 0
        self.currentStreak = 0
        self.lastPlayedDate = Date()
        self.favoriteMode = nil
        self.totalPlayTime = 0
    }
}

class ProgressManager {
    var userProgress: UserProgress
    private let userDefaults: UserDefaults
    private let progressKey = "userProgress"
    
    init() {
        self.userDefaults = UserDefaults.standard
        self.userProgress = Self.loadProgress(userDefaults: userDefaults, key: progressKey)
    }
    
    // MARK: - Level Management
    
    func completeLevel(mode: String, level: Int) {
        let levelKey = "\(mode)_\(level)"
        if !userProgress.completedLevels.contains(levelKey) {
            userProgress.completedLevels.insert(levelKey)
            userProgress.currentStreak += 1
            userProgress.bestStreak = max(userProgress.bestStreak, userProgress.currentStreak)
            saveProgress()
        }
    }
    
    func isLevelCompleted(mode: String, level: Int) -> Bool {
        let levelKey = "\(mode)_\(level)"
        return userProgress.completedLevels.contains(levelKey)
    }
    
    func getCompletedLevelsCount(for mode: String) -> Int {
        return userProgress.completedLevels.filter { $0.hasPrefix(mode) }.count
    }
    
    // MARK: - Statistics
    
    func updateGameStats(score: Int, playTime: TimeInterval) {
        userProgress.totalScore += score
        userProgress.totalGamesPlayed += 1
        userProgress.totalPlayTime += playTime
        userProgress.lastPlayedDate = Date()
        saveProgress()
    }
    
    func resetStreak() {
        userProgress.currentStreak = 0
        saveProgress()
    }
    
    func setFavoriteMode(_ mode: String) {
        userProgress.favoriteMode = mode
        saveProgress()
    }
    
    // MARK: - Data Persistence
    
    private func saveProgress() {
        if let data = try? JSONEncoder().encode(userProgress) {
            userDefaults.set(data, forKey: progressKey)
        }
    }
    
    private static func loadProgress(userDefaults: UserDefaults, key: String) -> UserProgress {
        if let data = userDefaults.data(forKey: key),
           let progress = try? JSONDecoder().decode(UserProgress.self, from: data) {
            return progress
        }
        return UserProgress()
    }
    
    // MARK: - Reset Data
    
    func resetAllProgress() {
        userProgress = UserProgress()
        saveProgress()
    }
    
    func resetModeProgress(mode: String) {
        userProgress.completedLevels = userProgress.completedLevels.filter { !$0.hasPrefix(mode) }
        saveProgress()
    }
}