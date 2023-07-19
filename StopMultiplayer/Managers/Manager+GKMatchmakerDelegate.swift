//
//  Manager+GKMatchmakerDelegate.swift
//  StopMultiplayer
//
//  Created by thaxz on 19/07/23.
//

import Foundation
import GameKit

// Implementando os métodos necessários para usarmos o matchmaker

extension MatchManager: GKMatchmakerViewControllerDelegate {
    
    // Se achar
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true)
        startMatch(newMatch: match)
    }
    
    // Se der erro
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
    // Se for cancelada
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        // fechando
        viewController.dismiss(animated: true)
    }
    
}
