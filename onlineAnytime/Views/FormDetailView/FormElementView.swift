//
//  FormElementView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormElementView: View {
    var formElement: FormElementWithId
    var pageNumber: Int
    
    var body: some View {
        if self.pageNumber == self.formElement.formElement.element_page_number {
            switch self.formElement.formElement.element_type {
            case "text":
                FormTextView(textTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "matrix":
                FormMatrixView(matrixTitle: self.formElement.formElement.element_title, matrixId: self.formElement.formElement.element_id, matrixGuideline: self.formElement.formElement.element_guidelines, matrixConstraint: self.formElement.formElement.element_constraint)
            case "number":
                FormTextView(textTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "email":
                FormTextView(textTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "address":
                FormAddressView(addressTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "simple_name":
                FormNameView(nameTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "simple_phone":
                FormTextView(textTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "money":
                FormTextView(textTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "europe_date":
                FormDateView(dateTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "date":
                FormDateView(dateTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "time":
                FormTimeView(timeTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "page_break":
                PageBreakView()
            case "section":
                FormSectionView(sectionTitle: self.formElement.formElement.element_title)
            case "file":
                FormFileView(fileTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "textarea":
                FormTextAreaView(textAreaTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "radio":
                FormRadioView(radioTitle: self.formElement.formElement.element_title, radioId: self.formElement.formElement.element_id)
            case "select":
                FormSelectView(selectTitle: self.formElement.formElement.element_title, selectId: self.formElement.formElement.element_id)
            case "signature":
                FormSignView(signTitle: self.formElement.formElement.element_title, id: self.formElement.formElement.element_id)
            case "checkbox":
                FormCheckBoxView(checkboxTitle: self.formElement.formElement.element_title, checkboxtId: self.formElement.formElement.element_id)
            case "media":
                FormMediaView(src: self.formElement.formElement.element_media_image_src ?? "")
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
        FormElementView(formElement: FormElementWithId(formElement: self.formElement, formId: -1), pageNumber: pageNumber)
    }
}
