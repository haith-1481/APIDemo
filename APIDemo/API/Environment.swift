//
//  Environment.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/17/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation

enum Environment {
    case dev
    case staging
    case production

    var apiUrl: String {
        switch self {
        case .dev:
            return "https://ghibliapi.herokuapp.com"
        case .staging:
            return "https://ghibliapi.herokuapp.com"
        case .production:
            return "" // TODO: Add api url for production
        }
    }

    var version: String {
        return "/v1"
    }

    var baseUrl: String {
        return apiUrl
//        return "\(apiUrl)\(version)"
    }
}
