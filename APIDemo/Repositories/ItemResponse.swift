//
//  ItemResponse.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/17/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation

struct ItemResponse: Codable {
    var userId: Int?
    var email: String?

    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case email
    }
}
