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
    
    func getOptions(formId: Int, elementId: Int) -> [String] {
        var options: [String] = []
        
        for option in self.formElementOptions {
            if option.form_id == formId && option.element_id ==  elementId {
                options.append(option.option)
            }
        }
        
        return options
    }
}
