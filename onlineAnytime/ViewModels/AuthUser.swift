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
    
    // Make sure the API calls once they are finished modify the values on the Main Thread
    func signIn(email: String, password: String) {
        
            let params:[String:String] = ["email": email, "password": password]
            
            let url = URL(string: "https://online-anytime.com.au/olat/newapi/login")!
            
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
                self.signedIn = true
                dataProcess.dataProcess(token: self.token)
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
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
