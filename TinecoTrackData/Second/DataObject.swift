//
//  DataObject.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/2.
//

import Foundation
import SwiftyJSON
struct DataObject {
    
    let device_id: String
    let event: String
    let time: String
    let distinct_id: String
    let properties: Properties
    
    init(_ json: JSON) {
        device_id = json["device_id"].stringValue
        event = json["event"].stringValue
        time = json["time"].stringValue
        distinct_id = json["distinct_id"].stringValue
        properties = Properties(json["properties"])
    }
    
    struct Properties {
        let app_version: String
        let manufacturer: String
        let os: String
        let model: String
        let os_version: String
        let lib_version: String
        let lib: String
        let phone_type: String
        let screen_name: String
        let params: Params?
        
        init(_ json: JSON) {
            app_version = json["app_version"].stringValue
            manufacturer = json["manufacturer"].stringValue
            os = json["os"].stringValue
            model = json["model"].stringValue
            os_version = json["os_version"].stringValue
            lib_version = json["lib_version"].stringValue
            lib = json["lib"].stringValue
            phone_type = json["phone_type"].stringValue
            screen_name = json["screen_name"].stringValue
            params = Params(json["params"])
        }
    }
}
struct Params {
    let authSign: String
    let uid: String
    let accessToken: String
    let authAppkey: String
    let requestId: String
    let authTimeZone: String
    let authTimespan: String
    
    init(_ json: JSON) {
        authSign = json["authSign"].stringValue
        uid = json["uid"].stringValue
        accessToken = json["accessToken"].stringValue
        authAppkey = json["authAppkey"].stringValue
        requestId = json["requestId"].stringValue
        authTimeZone = json["authTimeZone"].stringValue
        authTimespan = json["authTimespan"].stringValue
    }
}
