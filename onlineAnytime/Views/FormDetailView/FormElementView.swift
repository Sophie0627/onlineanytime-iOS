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
            switch self.formElement.element_type {
            case "text":
                FormTextView(textTitle: self.formElement.element_title)
            case "number":
                FormTextView(textTitle: self.formElement.element_title)
            case "email":
                FormTextView(textTitle: self.formElement.element_title)
            case "address":
                FormTextView(textTitle: self.formElement.element_title)
            case "simple_name":
                FormTextView(textTitle: self.formElement.element_title)
            case "simple_phone":
                FormTextView(textTitle: self.formElement.element_title)
            case "money":
                FormTextView(textTitle: self.formElement.element_title)
            case "europe_date":
                FormDateView(dateTitle: self.formElement.element_title)
            case "date":
                FormDateView(dateTitle: self.formElement.element_title)
            case "time":
                FormTimeView(timeTitle: self.formElement.element_title)
            case "page_break":
                PageBreakView()
            case "section":
                FormTextView(textTitle: self.formElement.element_title)
//                TextCustom(html: self.formElement.element_title)
            case "file":
                FormFileView(fileTitle: self.formElement.element_title)
            case "textarea":
                FormTextAreaView(textAreaTitle: self.formElement.element_title)
            case "radio":
                FormRadioView(radioTitle: self.formElement.element_title, radioId: self.formElement.element_id)
            case "select":
                FormSelectView(selectTitle: self.formElement.element_title, selectId: self.formElement.element_id)
            case "signature":
                FormSignView(signTitle: self.formElement.element_title)
            case "checkbox":
                FormCheckBoxView(checkboxTitle: self.formElement.element_title, checkboxtId: self.formElement.element_id)
//                Text("\(pageNumber)Result: " + self.formElement.element_type)
            default:
                VStack {}
            }
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
