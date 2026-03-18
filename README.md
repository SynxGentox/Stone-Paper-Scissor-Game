# Stone-Paper-Scissor-Game

## Description
A SwiftUI implementation of Stone Paper Scissors with 
enum-driven game logic. The `Choices` enum owns its own 
win/loss calculation using a dictionary lookup table, 
keeping all game logic in one place rather than scattered 
across the view.

# Stone Paper Scissors
A classic game built in SwiftUI with clean enum-driven architecture.

## Highlights
- Game logic fully encapsulated in `Choices` enum
- `GamePhase` enum drives UI state transitions
- Reusable `ScoreLabel` component
- Custom `ViewModifier` for consistent typography

## Tech
- SwiftUI
- Enum-driven state management
- Custom ViewModifier
