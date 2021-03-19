//
//  AuthUser.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import Foundation

class AuthUser : ObservableObject {
    
    @Published var signedIn: Bool
    
    private var token: String = ""
    var dataProcess = DataProcess()
    
    init(signedIn:Bool) {
        self.signedIn = signedIn

    }
    
    func setToken(token: String) {
        self.token = token
    }
    
    func getToken() -> String {
        if(self.signedIn){
            return self.token
        }
        else{
            return ""
        }
    }
    
    func signOut(){
        self.signedIn = false
        self.token = ""
    }
}
