//
//  FormDetail.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import Foundation

struct FormElement: Codable {
    var element_id: Int
    var element_title: String
    var element_guidelines: String
    var element_type: String
    var element_position: Int
    var element_page_number: Int
    var element_default_value: String
    var element_constraint: String
    var element_address_hideline2: Int
    var element_media_type: String
    var element_media_image_src: String?
    var element_media_pdf_src: String?
    
    init(element_id: Int, element_title: String, element_guidelines: String, element_type: String, element_position: Int, element_page_number: Int, element_default_value: String, element_constraint: String, element_address_hideline2: Int, element_media_type: String, element_media_image_src: String?, element_media_pdf_src: String?) {
        self.element_id = element_id
        self.element_title = element_title
        self.element_guidelines = element_guidelines
        self.element_type = element_type
        self.element_position = element_position
        self.element_page_number = element_page_number
        self.element_default_value = element_default_value
        self.element_constraint = element_constraint
        self.element_address_hideline2 = element_address_hideline2
        self.element_media_type = element_media_type
        self.element_media_image_src = element_media_image_src
        self.element_media_pdf_src = element_media_pdf_src
    }
}

struct FormDetailResponse: Codable {
    var success: Bool
    var forms: [FormElement]
}

struct FormElementWithId {
    var formElement: FormElement
    var formId: Int
    
    init(formElement: FormElement, formId: Int) {
        self.formElement = formElement
        self.formId = formId
    }
}
