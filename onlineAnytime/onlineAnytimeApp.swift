//
//  onlineAnytimeApp.swift
//  onlineAnytime
//
//  Created by Sophie on 3/8/21.
//

import SwiftUI

@main
struct onlineAnytimeApp: App {
    
    @StateObject var authUser = AuthUser(signedIn: false)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authUser)
        }
    }
}
