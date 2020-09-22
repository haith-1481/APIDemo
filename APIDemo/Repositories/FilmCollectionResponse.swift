//
//  FilmCollectionResponse.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/18/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit

struct FilmCollectionResponse: Codable {
    var filmCollection: [FilmResponse]?
    
    private enum CodingKeys: String, CodingKey {
        case filmCollection = ""
    }
}

struct FilmResponse: Codable {
    var id: String?
    var title: String?
    var description: String?
    var director: String?
    var producer: String?
    var releaseDate: String?
    var rateScore: String?
    var image = UIImage()

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case director
        case producer
        case releaseDate = "release_date"
        case rateScore = "rt_score"
    }
}
