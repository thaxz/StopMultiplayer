//
//  MatchManager.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import Foundation

final class MatchManager: ObservableObject {
    
    // game status
    @Published var isInGame: Bool = false
    @Published var isGameOver: Bool = false
    
    // Draw related
    @Published var currentlyDrawing: Bool = false
    @Published var drawPrompt: String = ""
    @Published var pastGuesses: [PastGuess] = []
    
    // Pontuation
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
    
    // state of auth
    @Published var authenticationState: PlayerAuthState = .authenticating
    
    
}
