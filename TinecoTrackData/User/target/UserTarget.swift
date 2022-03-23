//
//  UserTarget.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/14.
//

import Foundation
import Moya
import RxSwift
let UserProvider = MoyaProvider<UserTarget>.initProvider()

enum UserTarget {
    case login(username: String, password: String)
    case repassword(username: String, password: String, newPassword: String)
}

extension UserTarget: BaseTarget {
    
    var path: String {
        switch self {
        case .login(username: _, password: _):
            return "/monitor/user/login"
        case .repassword(username: _, password: _, newPassword: _):
            return "/monitor/user/repassword"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(username: _, password: _),
                .repassword(username: _, password: _, newPassword: _):
            return .post
        }
    }
    
    var task: Moya.Task {
        var parameters: [String: Any] = [:]
        switch self {
        case .login(username: let username, password: let password):
            parameters = ["username": username, "password": password]
        case .repassword(username: let username, password: let password, newPassword: let newPassword):
            parameters = ["username": username, "password": password, "newPassword": newPassword]
            parameters["access_token"] = User.fetch()?.access_token
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
}
