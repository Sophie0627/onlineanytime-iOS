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
    
    init(aeo_id: Int, form_id: Int, element_id: Int, option_id: Int, position: Int, option: String, option_is_default: Int, option_is_hidden: Int, live: Int) {
        self.aeo_id = aeo_id
        self.form_id = form_id
        self.element_id = element_id
        self.option_id = option_id
        self.option = option
        self.position = position
        self.option_is_default = option_is_default
        self.option_is_hidden = option_is_hidden
        self.live = live
    }
}

class FormElementOptionResponse: Codable {
    var forms: [FormElementOption]
    var checksum: String
    var success: Bool
}
