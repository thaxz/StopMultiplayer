//
//  Manager+GKMatchDelegate.swift
//  StopMultiplayer
//
//  Created by thaxz on 19/07/23.
//

import Foundation
import GameKit
import PencilKit

extension MatchManager: GKMatchDelegate {
    
    // Quando receber os dados
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        // decoding
        let content = String(decoding: data, as: UTF8.self)
        if content.starts(with: "strData:") {
            let message = content.replacing("strData:", with: "")
            receivedString(message)
        } else {
            // transformando em desenho
            do {
                try lastReceivedDrawing = PKDrawing(data: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // Vendo se a pessoa não desconectou
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
       
    }
    
    func sendString(_ message: String){
        // encoding
        guard let encoded = "strData:\(message)".data(using: .utf8) else {return}
        sendData(encoded, mode: .reliable)
    }
    
    // Mandando os dados para os jogadores
    func sendData(_ data: Data, mode: GKMatch.SendDataMode){
        do {
            try match?.sendData(toAllPlayers: data, with: mode)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}
