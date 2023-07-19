//
//  Manager+GKMatchDelegate.swift
//  StopMultiplayer
//
//  Created by thaxz on 19/07/23.
//

import Foundation
import GameKit

extension MatchManager: GKMatchDelegate {
    
    // Quando receber os dados
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        
    }
    
    // Vendo se a pessoa não desconectou
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        
    }
    
    func sendString(_ message: String){
        
    }
    
    func sendData(_ data: Data, mode: GKMatch.SendDataMode){
        
    }
    
    
    
}
