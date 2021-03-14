//
//  FormTextAreaView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormTextAreaView: View {
    
    var textAreaTitle: String
    @State private var profileText: String = "Please write"
    
    var body: some View {
        VStack {
            Text(self.textAreaTitle)
            TextEditor(text: $profileText)
                .foregroundColor(.secondary)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct FormTextAreaView_Previews: PreviewProvider {
    static var previews: some View {
        FormTextAreaView(textAreaTitle: "")
    }
}
