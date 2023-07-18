//
//  GameOverView.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var matchManager: MatchManager
    var body: some View {
        ZStack {
            Image("gameOverBg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Image("gameOver")
                    .resizable()
                    .scaledToFit()
                Text("Score: \(matchManager.score)")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.yellow)
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                Spacer()
                
                Button {
                    // do something
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.theme.green)
                            .frame(maxWidth: .infinity)
                            .frame(height: 65)
                        Text("Menu")
                            .font(.largeTitle)
                            .foregroundColor(Color.theme.purple)
                            .bold()
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            
        }
        
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(MatchManager())
    }
}
