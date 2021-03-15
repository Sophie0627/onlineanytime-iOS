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
    
    var body: some View {
        VStack(spacing: 0.0) {
            Color.green.overlay(
                HStack(content: {
                    Button(action: {
                        self.screenInfo.screenInfo = "home"
                        self.formElementList.formElementList = []
                    }) {
                        Image("back_icon").padding()
                    }
                    Text(self.screenInfo.formName).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
                    Text("Submit").foregroundColor(.white).padding()
                        .onTapGesture {
                            self.screenInfo.pageNumber += 1
                        }
                })
            ).frame(height: 60)
            ScrollView {
                VStack {
                    Text(self.screenInfo.formName).frame(maxWidth: .infinity).padding(.vertical, 10.0).frame(maxWidth: .infinity, alignment: .leading)
//                    HTMLStringView(htmlContent: self.screenInfo.formDescription)
//                    TextCustom(html: self.screenInfo.formDescription)
                    Text(self.screenInfo.formDescription.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).fixedSize(horizontal: false, vertical: true)
                    FormElementListView().frame(maxWidth: .infinity, alignment: .leading)
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

    
    static var previews: some View {
        FormDetailView()
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString("<p>" + htmlContent + "</p>", baseURL: nil)
    }
}


struct TextCustom: UIViewRepresentable {
  let html: String
  func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
    DispatchQueue.main.async {
      let data = Data(self.html.utf8)
      if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
        uiView.isEditable = false
        uiView.attributedText = attributedString
      }
    }
  }
  func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
    let label = UITextView()
    return label
  }
}
