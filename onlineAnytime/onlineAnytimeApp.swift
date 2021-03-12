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
    @StateObject var screenInfo = ScreenInfo(screenInfo: "home")
    @StateObject var formElementList = FormElementListViewModel(formElementList: [])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authUser)
                .environmentObject(screenInfo)
                .environmentObject(formElementList)
        }
    }
}
