//
//  ContentView.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import SwiftUI

//TODO: Refactor to make navigation with coordinator

struct ContentView: View {
    @EnvironmentObject var matchManager: MatchManager
    
    var body: some View {
        ZStack{
            if matchManager.isGameOver {
                GameOverView()
                    .environmentObject(matchManager)
            } else if matchManager.isInGame {
                GameView()
                    .environmentObject(matchManager)
            } else {
                MenuView()
                    .environmentObject(matchManager)
            }
        }
        .onAppear{
            matchManager.authenticateUser()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
