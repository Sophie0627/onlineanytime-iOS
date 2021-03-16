//
//  FormElementListView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormElementListView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        let formElementDB: FormElementDBHelper = FormElementDBHelper()
        VStack {
            ForEach(formElementDB.readFormElementByPageNumber(formId: self.screenInfo.formId, elementPageNumber: self.screenInfo.pageNumber), id: \.formElement.element_id) { formElement in
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
