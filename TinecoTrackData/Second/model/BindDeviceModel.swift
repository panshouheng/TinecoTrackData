//
//  BindDeviceModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import Foundation
/// 4.手机号查询登录的手机
struct BindDeviceModel: SwiftJSONModelAble {
    
    /// 手机型号
    let model: String
    /// 设备类型
    let deviceType: String
    /// 应用版本号
    let appVersion: String
    /// 系统版本号
    let systemVersion: String
    /// 设备编码
    let deviceNum: String
    /// app应用编码
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
