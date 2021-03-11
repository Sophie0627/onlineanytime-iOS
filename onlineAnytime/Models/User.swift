//
//  User.swift
//  onlineAnytime
//
//  Created by Sophie on 3/10/21.
//

import Foundation

struct UserInfo: Codable {
    var user_id: Int
    var user_fullname: String
    var token: String
    var success: Bool
}
