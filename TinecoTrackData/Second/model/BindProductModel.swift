//
//  BindProductModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import Foundation
/// 手机号查询绑定信息
struct BindProductModel: SwiftJSONModelAble {
    
    /// 设备昵称
    let nickname: String
    /// 设备id
    let productId: String
    /// 设备类型
    let type: String
    /// snCode
    let snCode: String
    /// 硬件版本号
    let hardwareVersion: String
    /// 软件版本号
    let softwareVersion: String
    /// 系统版本号
    let systemVersion: String
    /// 料盒sn
    let boxSn: String
    /// 锅唯一识别码
    let potSerialNum: String
    
    init(_ jsonData: JSON) {
        nickname = jsonData["nickname"].stringValue
        productId = jsonData["productId"].stringValue
        type = jsonData["type"].stringValue
        snCode = jsonData["snCode"].stringValue
        hardwareVersion = jsonData["hardwareVersion"].stringValue
        softwareVersion = jsonData["softwareVersion"].stringValue
        systemVersion = jsonData["systemVersion"].stringValue
        boxSn = jsonData["boxSn"].stringValue
        potSerialNum = jsonData["potSerialNum"].stringValue
    }
}
