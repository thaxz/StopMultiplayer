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
    @State var eraserEnabled: Bool = false
    
    var body: some View {
        ZStack {
            GeometryReader{ _ in
                // se é quem desenha ou quem advinha
                Image(matchManager.currentlyDrawing ? "drawerBg" : "guesserBg")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack(spacing: 16){
                    topBar
                    ZStack(alignment: .topTrailing){
                        DrawingView(eraserEnabled: $eraserEnabled)
                            .environmentObject(MatchManager())
                            .aspectRatio(1, contentMode: .fit)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 10)
                            }
                        eraserTool
                    }
                    
                    pastGuesses
                    Spacer()
                    promptGroup
                }
                .padding(16)
            }
            
        }
        
    }
}

// MARK: Components

extension GameView {
    
    var topBar: some View {
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
        
        .padding(.vertical, 15)
    }
    
    var eraserTool: some View {
        HStack{
            Spacer()
            // se estiver desenhando
            if matchManager.currentlyDrawing {
                Button {
                    eraserEnabled.toggle()
                } label: {
                    Image(systemName: eraserEnabled ? "eraser.fill" : "eraser")
                        .font(.title)
                        .foregroundColor(Color.theme.purple)
                }
            }
        } .padding(16)
    }
    
    var pastGuesses: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(matchManager.pastGuesses){ guess in
                    HStack{
                        Text(guess.message)
                            .font(.title2)
                            .bold(guess.isCorrect)
                        if guess.isCorrect {
                            Image(systemName: "hand.thumbsup.fill")
                                .foregroundColor(matchManager.currentlyDrawing ? Color.theme.yellow : Color.theme.purple)
                        }
                    }
                    .background(
                        matchManager.currentlyDrawing ? Color.theme.green : Color.theme.yellow
                    )
                    
                }
            }
            
        }
    }
    
    var promptGroup: some View {
        VStack{
            if matchManager.currentlyDrawing {
                Label("DRAW: ", systemImage: "exclamationmark.bubble.fill")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(matchManager.drawPrompt.uppercased())
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(Color.theme.yellow)
            } else {
                HStack{
                    Label("GUESS THE DRAWING: ", systemImage: "exclamationmark.bubble.fill")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.theme.purple)
                    Spacer()
                    
                }
                HStack {
                    TextField("Type your guess", text: $drawingGuess)
                        .padding()
                        .background(
                            Capsule(style: .circular)
                                .fill(.white)
                        )
                        .onSubmit {
                            makeGuess()
                        }
                    Button {
                        makeGuess()
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .renderingMode(.original)
                            .foregroundColor(Color.theme.purple)
                            .font(.system(size: 50))
                    }
                }
                
            }
        }
    }
    
    // MARK: Funções
    
    func makeGuess(){
        
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(MatchManager())
    }
}
