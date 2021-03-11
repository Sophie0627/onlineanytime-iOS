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
    
//    private var userInfo = [UserInfo]()
    
    func getToken(email: String, password: String) {
        let params:[String:String] = ["email": "sophie@sophie.com", "password": "sophie"]
        
        let url = URL(string: self.url)!
        
        ApiService.callPost(url: url, params: params, finish: self.finishPost)
        
    }
    
    func finishPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                print(parsedData)
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
