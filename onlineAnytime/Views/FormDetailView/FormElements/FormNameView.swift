//
//  FormNameView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/18/21.
//

import SwiftUI

struct FormNameView: View {
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var nameTitle: String = ""
    var id: Int = -1
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.nameTitle.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).fixedSize(horizontal: false, vertical: true)
            
            TextField("First Name", text: $firstName)
                .autocapitalization(.none)
                .onChange(of: firstName) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_1", value: self.firstName)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_1")
                    if str != "###"
                    {
                        self.firstName = str
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            TextField("Last Name", text: $lastName)
                .autocapitalization(.none)
                .onChange(of: lastName) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_2", value: self.lastName)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_2")
                    if str != "###"
                    {
                        self.lastName = str
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct FormNameView_Previews: PreviewProvider {
    static var previews: some View {
        FormNameView()
    }
}
