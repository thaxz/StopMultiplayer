//
//  MatchManager.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import Foundation
import GameKit
import PencilKit

final class MatchManager: NSObject, ObservableObject {
    
    // game status
    @Published var isInGame: Bool = false
    @Published var isGameOver: Bool = false
    
    // Draw related
    @Published var currentlyDrawing: Bool = true
    @Published var drawPrompt: String = ""
    @Published var pastGuesses: [PastGuess] = []
    
    // Pontuation and timer
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
    @Published var isTimeKeeper: Bool = false
    
    // Pencil data
    @Published var lastReceivedDrawing = PKDrawing()
    
    // state of auth
    @Published var authenticationState: PlayerAuthState = .authenticating
    
    // Creating match
    var match: GKMatch?
    var otherPlayer: GKPlayer?
    var localPlayer: GKLocalPlayer = GKLocalPlayer.local
    
    // Wich player goes first
    var playerUUIDKey = UUID().uuidString
    
    // Creating scene
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    // Authenticating user
    func authenticateUser(){
        // se tiver viewcontroller
        GKLocalPlayer.local.authenticateHandler = { [self] viewController, error in
            if let viewController = viewController {
                rootViewController?.present(viewController, animated: true)
                return
            }
            // se tiver erro
            if let error = error {
                authenticationState = .error
                print(error.localizedDescription)
                return
            }
            // se tiver autenticado
            if localPlayer.isAuthenticated {
                if localPlayer.isMultiplayerGamingRestricted {
                    authenticationState = .restricted
                } else {
                    // autenticado
                    authenticationState = .authenticaded
                }
            } else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    // Creating the match
    func startMatchMaking(){
        let request = GKMatchRequest()
        // Configurando o request
        request.minPlayers = 2
        request.maxPlayers = 2
        // Criando o view controller e colocando o delegate
        let matchVc = GKMatchmakerViewController(matchRequest: request)
        matchVc?.matchmakerDelegate = self
        // Present na tela
        rootViewController?.present(matchVc!, animated: true)
    }
    
    // Starting the match
    func startMatch(newMatch: GKMatch){
        match = newMatch
        match?.delegate = self
        // pegando o outro player
        otherPlayer = match?.players.first
        // gerando um prompt de desenho
        drawPrompt = everydayObjects.randomElement()!
        // decidindo assim quem vai primeiro
        sendString("Began: \(playerUUIDKey)")
    }
    
    // Received string
    func receivedString(_ message: String){
        let messageSplit = message.split(separator: ":")
        guard let messagePrefix = messageSplit.first else {return}
        let parameter = String(messageSplit.last ?? "")
        switch messagePrefix {
        case "began":
            if playerUUIDKey == parameter {
                playerUUIDKey = UUID().uuidString
                sendString("began:\(playerUUIDKey)")
                break
            }
            currentlyDrawing = playerUUIDKey < parameter
            // Starting the game
            isInGame = true
            isTimeKeeper = true
            // starting timer
            if isTimeKeeper {
                countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
        default:
            break
        }
    }
}
