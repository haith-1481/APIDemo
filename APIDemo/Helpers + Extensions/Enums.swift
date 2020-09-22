//
//  Enums.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/18/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit

enum API {
    case imgurlApi
    case ghibliApi
    
    var header: [String : String] {
        switch self {
        case .imgurlApi:
            return ["Authorization": "Client-ID 51b5b6d796c5b4d"]
        case .ghibliApi:
            return ["Content-Type": "application/json"]
        }
    }
    
    var url: String {
        switch self {
        case .imgurlApi:
            return "https://api.imgur.com/3/gallery/r/Hentai"
        case .ghibliApi:
            return "https://ghibliapi.herokuapp.com/films"
        }
    }
}

enum JPEGQuality: CGFloat {
    case lowest = 0
    case low = 0.25
    case medium = 0.5
    case high = 0.75
    case highest = 1
}

enum GhigbliFilm: String {
    case CastleInTheSky = "Castle in the Sky"
    case GraveOfTheFireflies = "Grave of the Fireflies"
    case MyNeighborTotoro = "My Neighbor Totoro"
    case KikiDeliveryService = "Kiki's Delivery Service"
    case OnlyYesterday = "Only Yesterday"
    case PorcoRosso = "Porco Rosso"
    case PomPoko = "Pom Poko"
    case WhisperOfTheHeart = "Whisper of the Heart"
    case PrincessMononoke = "Princess Mononoke"
    case MyNeighborsTheYamadas = "My Neighbors the Yamadas"
    case SpiritedAway = "Spirited Away"
    case TheCatReturns = "The Cat Returns"
    case HowlMovingCastle = "Howl's Moving Castle"
    case TalesFromEarthsea = "Tales from Earthsea"
    case Ponyo
    case Arrietty
    case FromUpOnPoppyHill = "From Up on Poppy Hill"
    case TheWindRises = "The Wind Rises"
    case TheTaleOfThePrincessKaguya = "The Tale of the Princess Kaguya"
    case WhenMarnieWasThere = "When Marnie Was There"
    
    var imageUrl: String {
        switch self {
        case .CastleInTheSky:
            return "https://static.fptplay.net/static/img/share/video/01_06_2017/pu8cdljiyonfrflwjeuliu8s4hq01-06-2017_15g43-42.jpg"
        case .GraveOfTheFireflies:
            return "https://www.denofgeek.com/wp-content/uploads/2018/04/grave-main.jpg?fit=1200%2C675"
        case .MyNeighborTotoro:
            return "https://cdn.vox-cdn.com/thumbor/6yITJIuEAdgWPx81QxmCojfR7Qg=/0x0:1920x1080/1400x1400/filters:focal(736x383:1042x689):format(jpeg)/cdn.vox-cdn.com/uploads/chorus_image/image/55049321/totoro.0.jpg"
        case .KikiDeliveryService:
            return "https://static0.cbrimages.com/wordpress/wp-content/uploads/2019/08/kiki.jpg"
        case .OnlyYesterday:
            return "https://cornellsun.com/wp-content/uploads/2016/03/maxresdefault5.jpg"
        case .PorcoRosso:
            return "https://images.cdn.circlesix.co/image/1/640/0/uploads/posts/2016/08/94da8eb4c43aefca91d4173bac261660.png"
        case .PomPoko:
            return "https://www.isthismoviesuitable.com/wp-content/uploads/2013/05/Pom-Poko-featured-image-1280x720.jpg"
        case .WhisperOfTheHeart:
            return "https://lh3.googleusercontent.com/proxy/LuYjjI_RyEdZRkhyE9fvVPU100xuuZljnTo4_Zx7h3QxaEe29MADTooG8jx4tYHab-_jdnW5EPG1o5cLlQ-PBQh6IvBddMprsmBmXrR9xrzIV6Ig2wglxfYBlsqWiA"
        case .PrincessMononoke:
            return "https://hollywoodforever.com/wp-content/uploads/2019/04/PM_1.png"
        case .MyNeighborsTheYamadas:
            return "https://www.japansociety.org/resources/legacy/event/yamadas_xl.jpg"
        case .SpiritedAway:
            return "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQZFoKOgjTI1rVj6YVCWNdY-QZ5uavTEp0v1A&usqp=CAU"
        case .TheCatReturns:
            return "https://d2e111jq13me73.cloudfront.net/sites/default/files/styles/share_link_image_large/public/screenshots/csm-movie/the-cat-returns-ss1.jpg?itok=0U4oSpm2"
        case .HowlMovingCastle:
            return "https://cdn.vox-cdn.com/thumbor/hHzi56bzWh3TaLYx7mHlRHe8UCk=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/20007566/GHI_HowlsMovingCastle_Select1.jpg"
        case .TalesFromEarthsea:
            return "https://contemplatrix.files.wordpress.com/2012/01/tales-from-earthsea-therru.jpg"
        case .Ponyo:
            return "https://lh3.googleusercontent.com/proxy/kRzFoMVwFcHk6LI0aLNg5ncHSRLoVzTHVt8ZyhGuyJU-6SiLo06ElJLcno9tu1YQ8f9Km2PZQHHZooi-8tJ_tNOOhlIwwBSmhnRQi8VloP-E6HPzZKxQ5QCFhWsWpQdcjm8"
        case .Arrietty:
            return "https://i.pinimg.com/originals/27/4b/67/274b67c33a814559918d9c9aca729efa.jpg"
        case .FromUpOnPoppyHill:
            return "https://media.wired.com/photos/593385912a38e4432c4b9e23/master/pass/poppy.jpg"
        case .TheWindRises:
            return "https://media.npr.org/assets/img/2014/02/21/nahoko_wide-ede1515b2d5f1a398d8cbbb1305cbdddb17cd0ad.jpg?s=1400"
        case .TheTaleOfThePrincessKaguya:
            return "https://s3-eu-west-1.amazonaws.com/static.melkweg.nl/uploads/images/scaled/theme_slider_large/26463"
        case .WhenMarnieWasThere:
            return "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT9GLh1a34PvMt3irc0XsUVAi5otNyi0Ym-Fg&usqp=CAU"
        default:
            return ""
        }
    }
}
