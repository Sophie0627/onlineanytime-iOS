//
//  FormDetailView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import SwiftUI
import WebKit

struct FormDetailView: View {
    
    @EnvironmentObject var authUser: AuthUser
    @EnvironmentObject var screenInfo: ScreenInfo
    @EnvironmentObject var formElementList: FormElementListViewModel
    @State var pageNumber: Int = 1
    
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
                        .onTapGesture {
                            self.pageNumber += 1
                        }
                })
            ).frame(height: 60)
            ScrollView {
                VStack {
                    Text(self.screenInfo.formName).frame(maxWidth: .infinity).padding(.vertical, 10.0).frame(maxWidth: .infinity, alignment: .leading)
//                    HTMLStringView(htmlContent: self.screenInfo.formDescription)
                    FormElementListView(pageNumber: self.$pageNumber).frame(maxWidth: .infinity, alignment: .leading)
                }
            }.padding()
            .frame(maxHeight: .infinity)
            
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
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(FormDetailResponse.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.formElementList.formElementList = decodedResponse.forms
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct FormDetailView_Previews: PreviewProvider {
    
    @State static var pageNumber: Int = 1
    
    static var previews: some View {
        FormDetailView(pageNumber: self.pageNumber)
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString("<font size=10>" + htmlContent + "</font>", baseURL: nil)
    }
}
