//
//  BindProductModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import Foundation
///3.手机号查询绑定信息
struct BindProductModel: SwiftJSONModelAble {
    
    let nickname: String
    let productId: String
    let type: String
    let snCode: String
    let hardwareVersion: String
    let softwareVersion: String
    let systemVersion: String
    let boxSn: String
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
