//
//  BluetoothBySnCodeModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/23.
//

import Foundation
import sqlcipher

struct SnCodeModel: SwiftJSONModelAble {
    
    let identifierId: String
    let nickname: String
    let username: String
    let mobile: String
    let internalUser: Bool
    let email: String
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
