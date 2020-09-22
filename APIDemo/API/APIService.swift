//
//  APIService.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/17/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Alamofire
import RxSwift
import UIKit

enum RequestType {
    case unchecked
    case checked
}

class APIService {
    private var uploadSessionManager: Alamofire.Session?

    func request<T: Decodable>(router: APIRouter, type: RequestType = .checked) -> Single<T> {
        if !ReachabilityManager.isNetworkConnected() {
            return Single.error(APIError.network)
        }
        if type == .checked {
//            Loading.show()
        }
        return Single<T>.create { singleEvent in
            let request = AF.request(router).responseDecodable { [weak self] (response: DataResponse<T, AFError>) in
                self?.processResponse(response, singleEvent: singleEvent)
                if type == .checked {
//                    Loading.hide()
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    func upload<T: Decodable>(router: APIRouter, type: RequestType = .checked) -> Single<T> {
        if !ReachabilityManager.isNetworkConnected() {
            return Single.error(APIError.network)
        }
        if type == .checked {
//            Loading.show()
        }
        return Single<T>.create { singleEvent in
            let request = AF.upload(multipartFormData: router.multipartFormData(), to: router).responseDecodable { [weak self] (response: DataResponse<T, AFError>) in
                self?.processResponse(response, singleEvent: singleEvent)
                if type == .checked {
//                    Loading.hide()
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    private func processResponse<T>(_ response: DataResponse<T, AFError>, singleEvent: @escaping (SingleEvent<T>) -> Void) {
        switch response.result {
        case let .success(value):
            guard let code = response.response?.statusCode,
                let statusCode = HttpStatusCode(rawValue: code) else {
                errorHandle(error: APIError.other, singleEvent)
                return
            }
            if let responseData = response.data {
                print("Response Data: \(String(data: responseData, encoding: .utf8).debugDescription)")
            }
            switch statusCode {
            case .ok, .created:
                singleEvent(.success(value))
            default:
                do {
                    if let data = response.data {
                        let errorResponse = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                        errorHandle(error: errorResponse, singleEvent)
                    } else {
                        errorHandle(error: APIError.other, singleEvent)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        case let .failure(error):
            errorHandle(error: error, singleEvent)
            print(error)
        }
    }

    private func errorHandle<T>(error: Error, _ singleEvent: @escaping (SingleEvent<T>) -> Void) {
        let errorMessageHandler: (String) -> Void = {
            (_: String) -> Void in
            singleEvent(.error(error))
        }
        guard let errorResponse = error as? APIErrorResponse else {
            errorMessageHandler(error.localizedDescription)
            return
        }
        errorMessageHandler(errorResponse.localizedDescription)
    }

    class func isNetworkConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

