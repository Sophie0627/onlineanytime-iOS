//
//  MenuView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image("doc_icon").frame(width: 40, height: 40)
                Text("My courses").foregroundColor(.white)
            }.padding(.top, 100.0)
            
            HStack{
                Image("setting_icon").frame(width: 40, height: 40)
                Text("Settings").foregroundColor(.white)
            }.padding(.top, 30.0)
            
            HStack{
                Image("logout").frame(width: 40, height: 40)
                Text("Log out").foregroundColor(.white)
            }.padding(.top, 30.0)
            
            Spacer()
        }.padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.green)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
