# Pop the Lock - WatchOS Game

A fun and challenging lock-picking game for Apple Watch with multiple difficulty modes and 300 levels total.

## 🎮 Game Features

- **6 Difficulty Modes**: Super Easy, Easy, Medium, Advanced, Hard, Expert
- **50 Levels per Mode**: 300 total levels to complete
- **Progressive Difficulty**: Each level requires more hits (level number = target score)
- **Speed-Based Modes**: Modes differ only by rotation speed
- **Persistent Progress**: Your completed levels are saved
- **Haptic Feedback**: Success and failure vibrations

## 🏗️ Project Structure

```
Pop the Lock Watch App/
├── Models/
│   └── GameState.swift          # Core game logic and state management
├── Views/
│   ├── Pop_the_LockApp.swift    # Main app entry point
│   ├── ContentView.swift        # Main app router
│   ├── ModeSelectView.swift     # Mode selection screen
│   ├── LevelSelectView.swift    # Level grid selection
│   ├── GameView.swift           # Main gameplay screen
│   ├── GameOverView.swift       # Game over screen
│   ├── LevelCompleteView.swift  # Level completion popup
│   └── ModeCompleteView.swift   # Mode completion celebration
├── Utils/
│   └── GameConstants.swift      # Game configuration constants
└── Assets.xcassets/             # App icons and colors
```

## 🎯 How to Play

1. **Choose Mode**: Select your preferred speed (Super Easy to Expert)
2. **Pick Level**: Choose any level from 1-50
3. **Hit the Target**: Tap when the orange line hits the green
4. **Complete Level**: Hit the green the number of times shown in the level number
5. **Progress**: Unlock new levels and complete entire modes

## 🔧 Technical Details

- **Framework**: SwiftUI + WatchKit
- **Architecture**: MVVM with ObservableObject
- **Storage**: UserDefaults for progress persistence
- **Performance**: 60 FPS smooth rotation
- **Target Platform**: watchOS 9.0+

## 🎨 Game Mechanics

- **Target Score**: Level number (Level 5 = 5 hits required)
- **Speed Progression**: Increases slightly with each successful hit
- **Direction Reversal**: Line alternates direction on every tap
- **Tolerance**: 15-degree hit detection window
- **Visual Feedback**: Glowing effects and shadows

## 📱 Controls

- **Tap Anywhere**: Hit the green target
- **Navigation**: Use buttons to move between screens
- **Level Selection**: Grid of 50 numbered buttons per mode

## 🏆 Completion System

- **Level Complete**: Shows score and next level option
- **Mode Complete**: Celebration when all 50 levels finished
- **Progress Tracking**: Visual checkmarks on completed levels
- **Persistent Storage**: Progress saved between app launches

## 🎮 Mode Differences

| Mode | Speed | Description |
|------|-------|-------------|
| Super Easy | 0.5x | Very slow, perfect for beginners |
| Easy | 0.8x | Slow and manageable |
| Medium | 1.2x | Normal speed |
| Advanced | 1.6x | Fast and challenging |
| Hard | 2.0x | Very fast |
| Expert | 2.5x | Lightning fast, expert level |

## 🔄 Future Enhancements

- Achievement system
- Leaderboards
- Custom themes
- Sound effects
- More game modes
- Level editor
