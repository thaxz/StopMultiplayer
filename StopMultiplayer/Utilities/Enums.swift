//
//  Enums.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import Foundation

// State of authentication

enum PlayerAuthState: String {
    
    case authenticating = "Loggin in into Game Center"
    case unauthenticated = "Please sign in to Game Center to play"
    case authenticaded = ""
    
    case error = "There was an error logging into Game Center"
    case restricted = "You are not allowed to play multiplayer games"
    
}

// To see past guesses

struct PastGuess: Identifiable {
    
    let id = UUID()
    var message: String
    var isCorrect: Bool
}
