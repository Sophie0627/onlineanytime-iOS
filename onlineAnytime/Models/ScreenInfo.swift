//
//  ScreenInfo.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import Foundation

class ScreenInfo : ObservableObject {
    
    @Published var screenInfo: String
    
    init(screenInfo: String) {
        self.screenInfo = screenInfo
    }
}
