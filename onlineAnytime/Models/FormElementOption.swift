//
//  FormElementOption.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import Foundation

class FormElementOption: Codable {
    var aeo_id: Int
    var form_id: Int
    var element_id: Int
    var option_id: Int
    var position: Int
    var option: String
    var option_is_default: Int
    var option_is_hidden: Int
    var live: Int
}

class FormElementOptionResponse: Codable {
    var forms: [FormElementOption]
    var checksum: String
    var success: Bool
}
