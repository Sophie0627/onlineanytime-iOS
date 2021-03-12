//
//  FormElementOptionViewModel.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import Foundation

class FormElementOptionViewModel: ObservableObject {
    @Published var formElementOptions: [FormElementOption]
    
    init(formElementOptions: [FormElementOption]) {
        self.formElementOptions = formElementOptions
    }
}
