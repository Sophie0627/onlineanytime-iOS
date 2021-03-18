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
    
    var body: some View {
        VStack(spacing: 0.0) {
            Color.green.overlay(
                HStack(content: {
                    Button(action: {
                        self.screenInfo.screenInfo = "home"
                        self.screenInfo.keys = []
                        self.screenInfo.values = []
                    }) {
                        Image("back_icon").padding()
                    }
                    Text(self.screenInfo.formName).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
                    CustomButton()
                })
            ).frame(height: 60)
            ScrollView {
                VStack {
                    Text(self.screenInfo.formName).frame(maxWidth: .infinity).padding(.vertical, 10.0).frame(maxWidth: .infinity, alignment: .leading)
                    Text(self.screenInfo.formDescription.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).fixedSize(horizontal: false, vertical: true)
                    FormElementListView().frame(maxWidth: .infinity, alignment: .leading)
                    SubmitButton()
                }
            }.padding()
            .frame(maxHeight: .infinity)
            
        }
    }
}

struct CustomButton: View {
    @EnvironmentObject var screenInfo: ScreenInfo
    @EnvironmentObject var authUser: AuthUser
    var status: Bool = Reach().isOnline()
    
    func encodedString(arr: [String]) -> String {
        var encodedString: String = ""
        for element in arr {
            encodedString += "\(element)##"
        }
        return encodedString
    }
    
    var body: some View {
        let formElementDB: FormElementDBHelper = FormElementDBHelper()
        if self.screenInfo.pageNumber == formElementDB.getPageNumber(formId: self.screenInfo.formId) {
            Text("Submit").foregroundColor(.white).padding()
                .onTapGesture {
                    print("------------ok-------------")
                    let formSubmitDB: FormSubmitDBHelper = FormSubmitDBHelper()
                    if self.status {
                        ApiService.submit(token: self.authUser.getToken(), formId: screenInfo.formId, keys: screenInfo.keys, values: screenInfo.values)
                    } else {
                        formSubmitDB.insert(formId: screenInfo.formId, keys: self.encodedString(arr: screenInfo.keys), values: encodedString(arr: screenInfo.values))
                    }
                    self.screenInfo.screenInfo = "home"
                    self.screenInfo.keys = []
                    self.screenInfo.values = []
                }
        } else {
            Text("Continue").foregroundColor(.white).padding()
                .onTapGesture {
                    self.screenInfo.pageNumber += 1
                }
        }
    }
}

struct SubmitButton: View {
    @EnvironmentObject var screenInfo: ScreenInfo
    @EnvironmentObject var authUser: AuthUser
    var status: Bool = Reach().isOnline()
    
    func encodedString(arr: [String]) -> String {
        var encodedString: String = ""
        for element in arr {
            encodedString += "\(element)##"
        }
        return encodedString
    }
    
    var body: some View {
        let formElementDB: FormElementDBHelper = FormElementDBHelper()
        if self.screenInfo.pageNumber == formElementDB.getPageNumber(formId: self.screenInfo.formId) {
            Button(action: {
                let formSubmitDB: FormSubmitDBHelper = FormSubmitDBHelper()
                if self.status {
                    ApiService.submit(token: self.authUser.getToken(), formId: screenInfo.formId, keys: screenInfo.keys, values: screenInfo.values)
                } else {
                    formSubmitDB.insert(formId: screenInfo.formId, keys: self.encodedString(arr: screenInfo.keys), values: encodedString(arr: screenInfo.values))
                }
                self.screenInfo.screenInfo = "home"
                self.screenInfo.keys = []
                self.screenInfo.values = []
            }) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("SUBMIT").bold().foregroundColor(.white)
                    Spacer()
                }
                                
            }.padding()
            .frame(width: 150)
            .background(Color.green)
            .cornerRadius(4.0)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
        } else {
            VStack {}
        }
    }
}

struct FormDetailView_Previews: PreviewProvider {

    
    static var previews: some View {
        FormDetailView()
    }
}

//struct HTMLStringView: UIViewRepresentable {
//    let htmlContent: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.loadHTMLString("<p>" + htmlContent + "</p>", baseURL: nil)
//    }
//}
//
//
//struct TextCustom: UIViewRepresentable {
//  let html: String
//  func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
//    DispatchQueue.main.async {
//      let data = Data(self.html.utf8)
//      if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//        uiView.isEditable = false
//        uiView.attributedText = attributedString
//      }
//    }
//  }
//  func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
//    let label = UITextView()
//    return label
//  }
//}
