//
//  FormDetailView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import SwiftUI

struct FormDetailView: View {
    
    @EnvironmentObject var authUser: AuthUser
    @EnvironmentObject var screenInfo: ScreenInfo
    @State var formInfo: String = ""
    
    var body: some View {
        VStack(spacing: 0.0) {
            Color.green.overlay(
                HStack(content: {
                    Button(action: {
                        self.screenInfo.screenInfo = "home"
                    }) {
                        Image("back_icon").padding()
                    }
                    Text(self.screenInfo.formName).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
                    Text("Submit").foregroundColor(.white).padding()
                })
            ).frame(height: 60)
            List {
                Text(self.screenInfo.formName).frame(maxWidth: .infinity).padding(.vertical, 10.0)
                Text(self.screenInfo.formDescription)
                Text(self.formInfo)
            }
        }.onAppear(perform: self.fetchFormInfo)
    }
    
    func fetchFormInfo() {
        guard let url = URL(string: "https://online-anytime.com.au/olat/newapi/form_elements/\(self.screenInfo.formId)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authUser.getToken(), forHTTPHeaderField: "token")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                self.formInfo = prettyPrintedJson
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
}

struct FormDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FormDetailView()
    }
}
