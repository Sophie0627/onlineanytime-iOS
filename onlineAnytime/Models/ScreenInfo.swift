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
    @Published var pageNumber: Int
    @Published var keys: [String]
    @Published var values: [String]
    @Published var homeStatus: String
    
    init(screenInfo: String) {
        self.screenInfo = screenInfo
        self.formId = -1
        self.formName = ""
        self.formDescription = ""
        self.pageNumber = 1
        self.keys = []
        self.values = []
        self.homeStatus = "first"
    }
    
    func setValues(elementId: String, value: String) {
        if let index = self.keys.firstIndex(of: elementId) {
            self.values[index] = value
        } else {
            self.keys.append(elementId)
            self.values.append(value)
        }
    }
    
    func getValue(elementId: String) -> String {
        if let index = self.keys.firstIndex(of: elementId) {
            return self.values[index];
        }
        return "###"
    }
}
