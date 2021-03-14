//
//  FormElementListView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormElementListView: View {
    
    @EnvironmentObject var formElementList: FormElementListViewModel
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        VStack {
//            TextCustom(html: self.screenInfo.formDescription)
            ForEach(self.formElementList.formElementList, id: \.element_id) { formElement in
                FormElementView(formElement: formElement, pageNumber: self.screenInfo.pageNumber)
            }
        }.padding()
    }
}

struct FormElementListView_Previews: PreviewProvider {
    
    static var previews: some View {
        FormElementListView()
    }
}
