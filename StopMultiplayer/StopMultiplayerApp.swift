//
//  StopMultiplayerApp.swift
//  StopMultiplayer
//
//  Created by thaxz on 18/07/23.
//

import SwiftUI

@main
struct StopMultiplayerApp: App {
    @StateObject private var matchManager = MatchManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(matchManager)
        }
    }
}
