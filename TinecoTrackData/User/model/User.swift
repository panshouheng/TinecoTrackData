//
//  LoginModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/18.
//

import Foundation
import WCDBSwift

struct User: SwiftJSONModelAble, TableCodable {
    
    let access_token: String
    let name: String
    let expire: Double
    let username: String
    let cellphone: String
    
    init(_ jsonData: JSON) {
        access_token = jsonData["access_token"].stringValue
        name = jsonData["name"].stringValue
        expire = jsonData["expire"].doubleValue
        username = jsonData["username"].stringValue
        cellphone = jsonData["cellphone"].stringValue
    }
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = User
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case access_token
        case name
        case expire
        case username
        case cellphone
    }
    
}
