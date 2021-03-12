//
//  FormTextView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormTextView: View {
    
    var textTitle: String
    @State private var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.textTitle).fixedSize(horizontal: false, vertical: true)
            TextField("Please write", text: $text)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct FormTextView_Previews: PreviewProvider {
    
    static var textTitle: String = ""
    
    static var previews: some View {
        FormTextView(textTitle: self.textTitle)
    }
}
