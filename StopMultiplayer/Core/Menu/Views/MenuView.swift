//
//  MenuView.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var matchManager: MatchManager
    
    var body: some View {
        ZStack {
            Image("menuBg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                Text(matchManager.authenticationState.rawValue)
                    .font(.headline)
                    .foregroundColor(Color.theme.yellow)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
                Spacer()
                
                Button {
                    matchManager.startMatchMaking()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                matchManager.authenticationState != .authenticaded || matchManager.isInGame ?
                                    .gray : Color.theme.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 65)
                        Text("PLAY")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                // Não vai funcionar o botão se não estiver autenticado ou se já estiver no jogo
                .disabled(matchManager.authenticationState != .authenticaded || matchManager.isInGame)
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(MatchManager())
    }
}
