//
//  ScreenInfo.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import Foundation

class ScreenInfo : ObservableObject {
    
    @Published var screenInfo: String
    @Published var formId: Int
    @Published var formName: String
    @Published var formDescription: String
    
    init(screenInfo: String) {
        self.screenInfo = screenInfo
        self.formId = -1
        self.formName = ""
        self.formDescription = ""
    }
}
