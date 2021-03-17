//
//  FormTextView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormTextView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var textTitle: String
    var id: Int
    @State private var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.textTitle.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).fixedSize(horizontal: false, vertical: true)
            TextField("Please write", text: $text)
                .autocapitalization(.none)
                .onChange(of: text) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)", value: self.text)
                }
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
        FormTextView(textTitle: self.textTitle, id: -1)
    }
}
