//
//  ReachabilityManager.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/17/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation
import Alamofire

class ReachabilityManager {
    class func isNetworkConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }

    static func startListeningNetworkConnection(connectedHandler: (() -> Void)?, disconnectedHandler: (() -> Void)?) {
        var isConnected = isNetworkConnected()
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { _ in
            guard isConnected != isNetworkConnected() else { return }
            isConnected = isNetworkConnected()
            if isConnected {
                connectedHandler?()
            } else {
                disconnectedHandler?()
            }
        })
    }

    static func stopListeningNetworkConnection() {
        NetworkReachabilityManager.default?.stopListening()
    }
}
