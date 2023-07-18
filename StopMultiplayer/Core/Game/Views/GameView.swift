//
//  GameView.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var matchManager: MatchManager
    
    // Tirar daqui colocar na vm
    
    @State var drawingGuess: String = ""
    @State var eraserEnabled: String = ""
    
    var body: some View {
        ZStack {
            GeometryReader{ _ in
                // se é quem desenha ou quem advinha
                Image(matchManager.currentlyDrawing ? "drawBg" : "guesserBg")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack{
                    topBar
                    ZStack{
                        
                    }
                }
                .padding(16)
            }
        }
    }
}

// MARK: Components

extension GameView {
    
    var topBar: some View {
        ZStack{
            HStack{
                Button {
                    // TODO: Disconnect from game
                } label: {
                    Image(systemName: "arrowshape.turn.up.left.circle.fill")
                        .font(.largeTitle)
                        .tint(matchManager.currentlyDrawing ? Color.theme.yellow : Color.theme.purple)
                }
                Spacer()
                Label("\(matchManager.remainingTime)", systemImage: "clock.fill")
                    .font(.title2)
                    .bold()
                    .foregroundColor(matchManager.currentlyDrawing ? Color.theme.yellow : Color.theme.purple)
            }
        }
        .padding(.vertical, 15)
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(MatchManager())
    }
}
