//
//  FormElementListViewModel.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import Foundation

class FormElementListViewModel: ObservableObject {
    @Published var formElementList: [FormElement]
    
    init(formElementList: [FormElement]) {
        self.formElementList = formElementList
    }
}
