//
//  MyMoyaTarget.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/4.
//

import Foundation
import Moya

enum NetworkTarget {
    case searchaAssociation(keyword: String, version: String)
    case searchHot(version: String)
}
extension NetworkTarget: TargetType {
    var baseURL: URL { URL(string: "https://aiot-tineco-life.tineco.com/sw/searchapi/v1/private/CN/ZH_CN/8C3912EC-8E26-4A2B-A78B-B53CB337781A/global_a/1.2.1/appStore/2/food/three/app")! }
    
    var path: String {
        switch self {
        case .searchaAssociation: return "/search/association"
        case .searchHot: return "/search/hot"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchaAssociation(_, _), .searchHot(version: _):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .searchaAssociation(let keyword, let version):
            return .requestParameters(parameters: ["keyword": keyword, "version": version], encoding: JSONEncoding.default)
        case .searchHot(let version):
            return .requestParameters(parameters: ["version": version], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .searchaAssociation(let keyword, let version):
            let dateString = (Date().unixTimestamp*1000).int.string
            let randomString = (String.randomStr(len: 10))
            let string = "keyword=\(keyword)&version=\(version)&timestamp=\(dateString)&nonce=\(randomString)&token=EA248A0456528EF358EF209050CF0D16"
            let header = ["timestamp": dateString, "nonce": randomString, "sign": string.md5.uppercased()]
            return header
        case .searchHot(let version):
            let dateString = (Date().unixTimestamp*1000).int.string
            let randomString = (String.randomStr(len: 10))
            let string = "version=\(version)&timestamp=\(dateString)&nonce=\(randomString)&token=EA248A0456528EF358EF209050CF0D16"
            let header = ["timestamp": dateString, "nonce": randomString, "sign": string.md5.uppercased()]
            print("参数拼接=\(string)\nheaders=\(header)")
            return header
        }
    }
}
