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
    @State private var presentingToast: Bool = false
    
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
                                        
                    }.padding().background(Color.green)
                    .cornerRadius(4.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
//                    .toast(isPresented: $presentingToast) {
//                      print("Toast dismissed")
//                    } content: {
//                      ToastView("Loading...")
//                        .toastViewStyle(IndefiniteProgressToastViewStyle())
//                    }
                    
                    Text("www.civilsafety.edu.au")
                }
            )
            .edgesIgnoringSafeArea(.vertical)
        
    }
    
    func submit() {
        self.presentingToast = true
        self.authUser.signIn(email: self.email, password: self.password)
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
}
