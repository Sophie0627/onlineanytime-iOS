//
//  HomeListView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI

struct HomeListView: View {
    let listElements = [
        ListElement(name: "G2 Practical"),
        ListElement(name: "Enrolment Form - App Test Only"),
        ListElement(name: "SINGLE OFFLINE TEST - App Test Only"),
        ListElement(name: "MINI OFFLINE - App Test Only")
    ]

    var body: some View {
        List(listElements) { listElement in
            ListElementRow(listElement: listElement)
        }
    }
}

struct ListElement: Identifiable {
    let id = UUID()
    let name: String
}

struct ListElementRow: View {
    var listElement: ListElement

    var body: some View {
        HStack(content: {
            Image("doc_icon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/).foregroundColor(.black).padding(.leading, 0.0)
            Text("\(listElement.name)").frame(maxWidth: .infinity, alignment: .leading)
            Image("eye_icon").padding(.trailing, 0.0)
        })
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
