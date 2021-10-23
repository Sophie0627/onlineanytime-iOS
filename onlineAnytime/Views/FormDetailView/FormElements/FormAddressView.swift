//
//  FormAddressView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/18/21.
//

import SwiftUI

struct FormAddressView: View {
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var addressTitle: String = ""
    var id: Int = -1
    @State private var street: String = ""
    @State private var addressLine2: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zipCode: String = ""
    @State private var country: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.addressTitle.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).fixedSize(horizontal: false, vertical: true)
            
            TextField("Street Address", text: $street)
                .autocapitalization(.none)
                .onChange(of: street) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_1", value: self.street)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_1")
                    if str != "###"
                    {
                        self.street = str
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            TextField("Address Line 2", text: $addressLine2)
                .autocapitalization(.none)
                .onChange(of: addressLine2) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_2", value: self.addressLine2)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_2")
                    if str != "###"
                    {
                        self.addressLine2 = str
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            TextField("City", text: $city)
                .autocapitalization(.none)
                .onChange(of: city) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_3", value: self.city)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_3")
                    if str != "###"
                    {
                        self.city = str
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            TextField("State/Province/Region", text: $state)
                .autocapitalization(.none)
                .onChange(of: state) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_4", value: self.state)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_4")
                    if str != "###"
                    {
                        self.state = str
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            TextField("Postal/Zip Code", text: $zipCode)
                .autocapitalization(.none)
                .onChange(of: zipCode) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_5", value: self.zipCode)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_5")
                    if str != "###"
                    {
                        self.zipCode = str
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color("white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            TextField("Country", text: $country)
                .autocapitalization(.none)
                .onChange(of: country) { newValue in
                    screenInfo.setValues(elementId: "element_\(self.id)_6", value: self.country)
                }
                .onAppear(perform: {
                    let str: String = screenInfo.getValue(elementId: "element_\(self.id)_6")
                    if str != "###"
                    {
                        self.country = str
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

struct FormAddressView_Previews: PreviewProvider {
    static var previews: some View {
        FormAddressView()
    }
}
