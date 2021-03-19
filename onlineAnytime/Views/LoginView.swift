//
//  LoginView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI
import ToastUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authUser: AuthUser
    @EnvironmentObject var screenInfo: ScreenInfo
    @State private var isLoggingin: Bool = false
    @State private var isLoginFailed: Bool = false
    @State var toastText: String = "Logging in..."
    
    var body: some View {
        
        Color(red: 250, green: 250, blue: 250, opacity: 1.0)
            .overlay(
                VStack {
                    Image("login_logo")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fit)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
                    
                    Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    
                    TextField("Email address", text: $email)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color("white"))
                        .cornerRadius(4.0)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color("white"))
                        .cornerRadius(4.0)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Button(action: submit) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("SIGN IN").bold().foregroundColor(.white)
                            Spacer()
                        }
                                        
                    }
                    .toast(isPresented: self.$isLoggingin) {
                      print("Toast dismissed")
                    } content: {
                        ToastView(self.toastText)
                        .toastViewStyle(IndefiniteProgressToastViewStyle())
                    }
                    
                    .padding().background(Color.green)
                    .cornerRadius(4.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
                    
                    
                    Text("www.civilsafety.edu.au")
                }
                .alert(isPresented: $isLoginFailed) {
                    Alert(title: Text("ERROR!"), message: Text("Email or password is wrong! \nPlease enter correctly..."), dismissButton: .default(Text("Got it!")))
                }
            )
            .edgesIgnoringSafeArea(.vertical)
        
    }
    
    func submit() {
        self.isLoggingin = true
        self.toastText = "Logging in..."
        ApiService.signIn(email: self.email, password: self.password) { (signedIn, token) in
            
            self.authUser.setToken(token: token!)
            
            if !signedIn! {
                self.isLoggingin = false
                self.isLoginFailed = true
            } else {
                
                self.toastText = "Updating data..."
                DataProcess().dataUpdate(token: token!) { result in
                    print("Updating data....")
                    self.toastText = "Submitting data..."
                    DataProcess().dataSubmit(token: token!) { result in
                        print("Submitting data....")
                        self.authUser.signedIn = signedIn!
                        self.isLoggingin = false
                        self.screenInfo.homeStatus = "login"
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
}
