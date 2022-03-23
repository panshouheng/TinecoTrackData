//
//  AccountBindTarget.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import Foundation
import Moya

let AccountBindProvider = MoyaProvider<AccountBindTarget>.initProvider()

enum AccountBindTarget {
    case bindProduct(mobile: String)
    case bindDevice(mobile: String)
}

extension AccountBindTarget: BaseTarget {
    
    var path: String {
        switch self {
        case .bindProduct(mobile: _):
            return "/monitor/account/bind/product"
        case .bindDevice(mobile: _):
            return "/monitor/account/bind/device"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bindProduct(mobile: _),
                .bindDevice(mobile: _):
            return .get
        }
    }
    
    var task: Moya.Task {
        var parameters: [String: Any] = [:]
        switch self {
        case .bindProduct(mobile: let mobile):
            parameters = ["mobile": mobile]
        case .bindDevice(mobile: let mobile):
            parameters = ["mobile": mobile]
        }
        parameters["access_token"] = UserDefaults.standard.string(forKey: "access_token")
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}
