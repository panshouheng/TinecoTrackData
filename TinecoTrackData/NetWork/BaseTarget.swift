//
//  BaseTarget.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/15.
//

import Foundation
import Moya
import UIKit

protocol BaseTarget: TargetType {
    /// The target's base `URL`.
    var baseURL: URL { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: Moya.Method { get }

    /// Provides stub data for use in testing. Default is `Data()`.
    var sampleData: Data { get }

    /// The type of HTTP task to be performed.
    var task: Task { get }

    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}

extension BaseTarget {
    var baseURL: URL { APIConfig.baseURL }
    
    var headers: [String: String]? {
        var headerParams = ["Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded"]
        if let user = User.fetch() {
            if user.expired {
                User.delete()
                UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                TLToast.show("token过期，请重新登陆")
            } else {
                headerParams["access_token"] = user.access_token
            }
        }
        return headerParams
    }
}
