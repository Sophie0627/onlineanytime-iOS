//
//  HomeView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            TopNavView()
            SearchBar()
            VStack{}.frame(maxHeight: .infinity)
        }
    }
}

struct TopNavView: View {
    var body: some View {
        Color.green.overlay(
            HStack(content: {
                Image("menu").padding()
                Text("Online-Anytime").foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
                Text("Close app").foregroundColor(.white).padding()
            })
        ).frame(height: 45, alignment: .top)
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
    static var previews: some View {
        HomeView()
    }
}
