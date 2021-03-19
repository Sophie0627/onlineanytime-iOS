//
//  HomeView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI
import ToastUI

struct HomeView: View {
    
    @Binding var showMenu: Bool
    var status: Bool = Reach().isOnline()
    @State var isShownToast: Bool = false
    @State var toastText: String = ""
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        VStack(spacing: 0.0) {
            Color.green.overlay(
                HStack(content: {
                    Button(action: {
                        self.showMenu = true
                    }) {
                        Image("menu").padding()
                    }
                    Text("Online-Anytime").foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
                    Text("Close app").foregroundColor(.white).padding()
                        .onTapGesture {
                            exit(-1)
                        }
                })
            ).frame(height: 45, alignment: .top)
            SearchBar()
            .toast(isPresented: self.$isShownToast, dismissAfter: 2) {
              print("Toast dismissed")
            } content: {
                ToastView(self.toastText)
                .toastViewStyle(InfoToastViewStyle())
            }
            VStack{
                HomeListView()
            }.frame(maxHeight: .infinity)
        }.onAppear(perform: {
            if !status && self.screenInfo.homeStatus == "first" {
                self.isShownToast = true
                self.toastText = "Currently offline"
            }
            if !status && self.screenInfo.homeStatus == "submit" {
                self.isShownToast = true
                self.toastText = "Currently offline. \nData will be submitted, when you're online."
            }
        })
    }
}

struct SearchBar: View {
    @State private var keyword: String = ""
    
    var body: some View {
        Color.green.overlay(
            HStack{
                TextField("Search Here", text: $keyword).textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color("white"))
                    .cornerRadius(4.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        ).frame(height: 45, alignment: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    
    @State static var showMenu: Bool = false
    
    static var previews: some View {
        HomeView(showMenu: $showMenu)
    }
}
