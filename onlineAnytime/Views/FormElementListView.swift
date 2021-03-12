//
//  FormElementListView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormElementListView: View {
    
    @Binding var pageNumber: Int
    @EnvironmentObject var formElementList: FormElementListViewModel
    
    var body: some View {
        VStack {
            ForEach(self.formElementList.formElementList, id: \.element_id) { formElement in
                FormElementView(formElement: formElement, pageNumber: self.pageNumber)
            }
        }
    }
}

struct FormElementListView_Previews: PreviewProvider {
    
    @State static var pageNumber: Int = 1
    
    static var previews: some View {
        FormElementListView(pageNumber: self.$pageNumber)
    }
}
