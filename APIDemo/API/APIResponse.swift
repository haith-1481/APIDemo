//
//  APIResponse.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/17/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation

enum APIError: Error {
    case network
    case unauthorized
    case expiredToken
    case badRequest(String?, String?)
    case notFound
    case other
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network:
            return "No internet connection"
        case .other:
            return "Undefined error"
        default:
            return nil
        }
    }
}

enum ErrorCodeDefined: Int {
    case tokenNotSet = 1001
    case newToken = 1002
    case userNotExist = 1003
    case tokenNotFound = 1004
    case requiredParams = 2001
    case requiredParamsData = 3001
    case forbidden = 3002
    case idPassNotFound = 3003
    case loginUserNotExist = 3004
    case requiredField = 3005
    case valueNotExist = 3006
}

enum HttpStatusCode: Int, Decodable {
    case ok = 200
    case created = 201
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case notAllowed = 405
    case codeInvalid = 406
    case conflict = 409
    case lengthRequired = 411
    case preconditionFailed = 412
    case missingRequiredParams = 422
    case tooManyAttemps = 429
    case internalError = 500
    case offlineMaintainace = 503
    case networkError
    case unknown
    case uploadFailed
    case accessTokenExpired = 1029
    case requiredBankAccount = 1041
}

struct APIResponse<T: Decodable>: Decodable {
    var data: T?
}

struct MessageResponse: Decodable {
    var message: String?
}

struct APIErrorResult: Decodable {
    var errorCode: Int?
    var errorMessage: String?
    var info: String?
}

struct APIErrorResponse: Error, Decodable {
    var errorCode: HttpStatusCode = .unknown
    var errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let errorCodeRawValue = try? container.decode(Int.self, forKey: .errorCode) {
            errorCode = HttpStatusCode(rawValue: errorCodeRawValue) ?? .unknown
        }
        errorMessage = try? container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
