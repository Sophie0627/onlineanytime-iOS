//
//  AuthUserViewModel.swift
//  onlineAnytime
//
//  Created by Sophie on 3/10/21.
//

import Foundation
import SwiftUI
import Combine

class AuthUserViewModel: ObservableObject {
    
    private let url = "https://online-anytime.com.au/olat/newapi/login"
    var token: String = "loggedOut"
    
    func getToken(email: String, password: String) {
        let params:[String:String] = ["email": email, "password": password]
        
        let url = URL(string: self.url)!
        
        ApiService.callPost(url: url, params: params, finish: self.finishPost)
        
    }
    
    func finishPost (message:String, data:Data?)
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                print(parsedData)
                self.token = parsedData.token
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
