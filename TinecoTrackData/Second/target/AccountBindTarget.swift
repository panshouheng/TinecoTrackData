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
    /// 手机号查询绑定信息
    case bindProduct(mobile: String)
    /// 手机号查询登录的手机
    case bindDevice(mobile: String)
    /// 蓝牙sn查询绑定的账号
    case bluetoothSnCode(sn: String)
    /// wifi sn查询绑定的账号
    case wifiSnCode(sn: String)
}

extension AccountBindTarget: BaseTarget {
    
    var path: String {
        switch self {
        case .bindProduct(mobile: _):
            return "/monitor/account/bind/product"
        case .bindDevice(mobile: _):
            return "/monitor/account/bind/device"
        case .bluetoothSnCode(sn: _):
            return "/bluetooth/getBySnCode"
        case .wifiSnCode(sn: _):
            return "/wifi/getBySnCode"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bindProduct(mobile: _),
                .bindDevice(mobile: _),
                .bluetoothSnCode(sn: _),
                .wifiSnCode(sn: _):
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
        case .bluetoothSnCode(sn: let sn):
            parameters = ["sn": sn]
        case .wifiSnCode(sn: let sn):
            parameters = ["sn": sn]
        }
        parameters["access_token"] = User.fetch()?.access_token
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}
