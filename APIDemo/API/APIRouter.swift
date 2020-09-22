//
//  APIRouter.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/17/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation
import Alamofire

private struct Constants {
    static let timeout: TimeInterval = 10.0
    static let accessToken: String? = ""
}

enum APIRouter: URLRequestConvertible {
    case getItem
    case patchItem(itemID: String)
    case postItem(item: FilmResponse)
    case getFilmCollection
    
    #if DEBUG
        static let baseURL = Environment.dev.baseUrl
    #elseif STAGING
        static let baseURL = Environment.staging.baseUrl
    #else
        static let baseURL = Environment.production.baseUrl
    #endif
    
    var method: HTTPMethod {
        switch self {
        case .getItem, .getFilmCollection:
            return .get
        case .patchItem:
            return .patch
        case .postItem:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getItem:
            return "/get"
        case let .patchItem(itemID):
            return "/patch/\(itemID)"
        case .postItem:
            return "/post"
        case .getFilmCollection:
            return "/films"
        }
    }
    
    var url: String {
        return "\(APIRouter.baseURL)\(path)"
    }
}
 
extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        urlRequest.timeoutInterval = Constants.timeout
        
        //MARK: --set up Header
        urlRequest.headers = HTTPHeaders.default
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

//        if let token = Constants.accessToken {
//            urlRequest.setValue("\(token)", forHTTPHeaderField: "Authorization")
//        }
        
        //MARK: --set up Body
        switch self {
        case .getItem:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .patchItem:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case let .postItem(item: item):
            let params: Parameters = ["item": item]
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        case .getFilmCollection:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        default:
            break
        }
        return urlRequest
    }
}

extension APIRouter: URLConvertible {
    func asURL() throws -> URL {
        return URL(string: url)!
    }

    func multipartFormData() -> MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
        case let .postItem(item: filmResponse):
            if let imageData = filmResponse.image.compressedData(.medium) {
                multipartFormData.append(imageData, withName: "profile_image_attributes[file]", fileName: "profile_image_attributes.jpeg", mimeType: "image/jpeg")
            }
            let parameters: [String: String?] = ["title": filmResponse.title]
            for (key, value) in parameters {
                multipartFormData.append((value?.data(using: .utf8))!, withName: key)
            }
        default:
            break
        }
        return multipartFormData
    }
}
