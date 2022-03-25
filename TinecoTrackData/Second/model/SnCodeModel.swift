//
//  BluetoothBySnCodeModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/23.
//

import Foundation
import sqlcipher

struct SnCodeModel: SwiftJSONModelAble {
    
    /// 用户id
    let identifierId: String
    /// 用户昵称
    let nickname: String
    /// 添可id
    let username: String
    /// 手机号
    let mobile: String
    /// 是否内部用户
    let internalUser: Bool
    /// 邮箱
    let email: String
    /// 注册地区/国家
    let registerArea: String
    
    init(_ jsonData: JSON) {
        identifierId = jsonData["id"].stringValue
        nickname = jsonData["nickname"].stringValue
        username = jsonData["username"].stringValue
        mobile = jsonData["mobile"].stringValue
        internalUser = jsonData["internalUser"].boolValue
        email = jsonData["email"].stringValue
        registerArea = jsonData["registerArea"].stringValue
    }
}
