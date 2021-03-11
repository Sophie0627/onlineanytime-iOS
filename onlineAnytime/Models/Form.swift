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
}
