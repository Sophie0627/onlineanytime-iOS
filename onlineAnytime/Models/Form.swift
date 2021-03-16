//
//  Form.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import Foundation

struct FormListResponse: Codable {
    var forms: [FormList]
    var checksum: String
    var success: Bool
}

struct FormList: Codable {
    var form_id: Int
    var form_name: String
    var form_description: String
    
    init(form_id: Int, form_name: String, form_description: String) {
        self.form_id = form_id
        self.form_name = form_name
        self.form_description = form_description
    }
}
