//
//  HomeListView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI

struct HomeListView: View {
    
    @EnvironmentObject var authUser: AuthUser
    @EnvironmentObject var formElementOptions: FormElementOptionViewModel
    
    @State private var formList = [FormList]()

    var body: some View {
        List(formList, id: \.form_id) { listElement in
            ListElementRow(listElement: listElement)
        }.onAppear(perform: fetchData)
    }
    
    func fetchData() {
        fetchFormData()
        fetchFormElementOption()
    }
    
    func fetchFormElementOption() {
        guard let url = URL(string: "https://online-anytime.com.au/olat/newapi/form_elements_options") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authUser.getToken(), forHTTPHeaderField: "token")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(FormElementOptionResponse.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.formElementOptions.formElementOptions = decodedResponse.forms
                    }
                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
       }.resume()
    }
    
    func fetchFormData() {
        guard let url = URL(string: "https://online-anytime.com.au/olat/newapi/forms") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authUser.getToken(), forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(FormListResponse.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.formList = decodedResponse.forms
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

struct ListElementRow: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    var listElement: FormList

    var body: some View {
        HStack(content: {
            Image("doc_icon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/).foregroundColor(.black).padding(.leading, 0.0)
            Text("\(listElement.form_name)").frame(maxWidth: .infinity, alignment: .leading)
            Image("eye_icon").padding(.trailing, 0.0)
        }).onTapGesture {
            self.screenInfo.screenInfo = "formDetail"
            self.screenInfo.formId = listElement.form_id
            self.screenInfo.formName = listElement.form_name
            self.screenInfo.formDescription = listElement.form_description
            self.screenInfo.pageNumber = 1
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
