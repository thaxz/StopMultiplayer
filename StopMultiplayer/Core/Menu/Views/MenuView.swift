//
//  MenuView.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        VStack {
            Spacer()
            
        Image("logo")
                .resizable()
                .scaledToFit()
                .padding(30)
            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(matchManager: MatchManager())
    }
}
