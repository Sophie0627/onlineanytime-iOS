//
//  MenuView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        Color.green.overlay(
            VStack(alignment: .leading) {
                Color.white.overlay(
                    HStack(alignment: .bottom) {
                        Image("app_logo")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .padding(EdgeInsets(top: 50, leading: 20, bottom: 10, trailing: 10))
                            .frame(height: 150.0)
                        Text("Dashboard").font(.headline).foregroundColor(.green).padding(.trailing, 20.0)
                    }
                ).frame(height: 150.0)
                
                HStack {
                    Image("doc_icon").frame(width: 40, height: 40)
                    Text("My courses").foregroundColor(.white)
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                HStack {
                    Image("setting_icon").frame(width: 40, height: 40)
                    Text("Settings").foregroundColor(.white)
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                HStack {
                    Image("logout").frame(width: 40, height: 40)
                    Text("Log out").foregroundColor(.white)
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                Spacer()
                
                Divider()
                
                HStack {
                    Image("profile_icon")
                    Text("sophie@sophie.com")
                }
                .padding(.leading, 20.0)
            }.padding(.horizontal, 0.0)
            .frame(maxWidth: .infinity, alignment: .leading)
    //        .background(Color.green)
            .edgesIgnoringSafeArea(.all)
        )
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
