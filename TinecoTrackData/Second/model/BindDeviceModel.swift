//
//  BindDeviceModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import Foundation
/// 4.手机号查询登录的手机
struct BindDeviceModel: SwiftJSONModelAble {
    
    let model: String
    let deviceType: String
    let appVersion: String
    let systemVersion: String
    let deviceNum: String
    let appCode: String
    
    init(_ jsonData: JSON) {
        model = jsonData["model"].stringValue
        deviceType = jsonData["deviceType"].stringValue
        appVersion = jsonData["appVersion"].stringValue
        systemVersion = jsonData["systemVersion"].stringValue
        deviceNum = jsonData["deviceNum"].stringValue
        appCode = jsonData["appCode"].stringValue
    }
}
