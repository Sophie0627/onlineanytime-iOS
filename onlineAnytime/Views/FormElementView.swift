//
//  FormElementView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormElementView: View {
    var formElement: FormElement
    var pageNumber: Int
    
    var body: some View {
        if self.pageNumber == self.formElement.element_page_number {
            Text("\(pageNumber)Result: " + self.formElement.element_type)
        } else {
            VStack {}
        }
    }
}

struct FormElementView_Previews: PreviewProvider {
    
    static var formElement: FormElement = FormElement(element_id: 1,
                                                      element_title: "Text Number",
                                                      element_guidelines: "",
                                                      element_type: "text",
                                                      element_position: 0,
                                                      element_page_number: 1,
                                                      element_default_value: "",
                                                      element_constraint: "",
                                                      element_address_hideline2: 0,
                                                      element_media_type: "image",
                                                      element_media_image_src: "",
                                                      element_media_pdf_src: "")
    static var pageNumber: Int = 1
    
    static var previews: some View {
        FormElementView(formElement: self.formElement, pageNumber: pageNumber)
    }
}
