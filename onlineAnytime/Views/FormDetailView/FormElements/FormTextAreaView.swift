//
//  FormTextAreaView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormTextAreaView: View {
    
    var textAreaTitle: String
    var id: Int
    @State private var profileText: String = "Please write"
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.textAreaTitle).fixedSize(horizontal: false, vertical: true)
            TextEditor(text: $profileText)
                .foregroundColor(.secondary)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: profileText) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)", value: self.profileText)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)")
                    if str != "###"
                    {
                        self.profileText = str
                    }
                })
        }
    }
}

struct FormTextAreaView_Previews: PreviewProvider {
    static var previews: some View {
        FormTextAreaView(textAreaTitle: "", id: -1)
    }
}
