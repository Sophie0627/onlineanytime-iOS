//
//  SettingsView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/10/21.
//

import SwiftUI

struct SettingsView: View {
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var lastDate: String = ""
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        VStack(spacing: 0.0) {
            Color.green.overlay(
                HStack(content: {
                    Button(action: {
                        self.screenInfo.screenInfo = "home"
                        self.screenInfo.homeStatus = ""
                    }) {
                        Image("back_icon").padding()
                    }
                    Text("Setting").foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
                })
            ).frame(height: 60)
            
            Color.gray.overlay(
                Text("Account Detail")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            ).frame(height: 50)
            
            TextField("Full name", text: $fullName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
            
            TextField("Email address", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
            
            Color.gray.overlay(
                Text("Sync Detail")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            ).frame(height: 50)
            
            TextField("Last Synchronize date", text: $lastDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
            
            Button(action: {}) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("SYNC NOW").bold().foregroundColor(.white)
                    Spacer()
                }
                                
            }.padding()
            .frame(width: 150)
            .background(Color.green)
            .cornerRadius(4.0)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
    }
}
