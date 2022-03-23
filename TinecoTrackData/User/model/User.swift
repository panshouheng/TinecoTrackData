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
    var expiration: Double
    var expired: Bool {
        self.expiration < Date().timeIntervalSince1970*1000
    }
    
    init(_ jsonData: JSON) {
        access_token = jsonData["access_token"].stringValue
        name = jsonData["name"].stringValue
        expire = jsonData["expire"].doubleValue
        username = jsonData["username"].stringValue
        cellphone = jsonData["cellphone"].stringValue
        expiration = jsonData["expire"].doubleValue + Date().timeIntervalSince1970*1000
    }
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = User
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case access_token
        case name
        case expire
        case username
        case cellphone
        case expiration
    }
}

extension User {
    
    func save() {
        try? WCDBManager.shared.dataBase.create(table: "user", of: User.self)
        try? WCDBManager.shared.dataBase.insertOrReplace(objects: self, intoTable: "user")
    }
    static func fetch() -> User? {
        let user: User? = try? WCDBManager.shared.dataBase.getObject(on: User.Properties.all, fromTable: "user", where: nil, orderBy: nil, offset: 0)
        return user
    }
    static func delete() {
        try? WCDBManager.shared.dataBase.delete(fromTable: "user", where: nil, orderBy: nil, limit: nil, offset: nil)
    }
    
}
