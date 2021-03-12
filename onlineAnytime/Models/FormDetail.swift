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
}

struct FormDetailResponse: Codable {
    var success: Bool
    var forms: [FormElement]
}
