//
//  HomeListView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/9/21.
//

import SwiftUI

struct HomeListView: View {
    
    @EnvironmentObject var authUser: AuthUser
//    @EnvironmentObject var formElementOptions: FormElementOptionViewModel
//
//    @State private var formList = [FormList]()

    var body: some View {
        let formDB: FormDBHelper = FormDBHelper()
        List(formDB.read(), id: \.form_id) { listElement in
            ListElementRow(listElement: listElement)
        }
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
