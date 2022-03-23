//
//  ResponseObject.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/10.
//

import Foundation
import SwiftyJSON

struct BaseResponse <T: SwiftJSONModelAble>: SwiftJSONModelAble {
    
    var code: Int
    var data: T
    var message: String
    var requestId: String

    init(_ jsonData: JSON) {
        code = jsonData["code"].intValue
        message = jsonData["message"].stringValue
        requestId = jsonData["requestId"].stringValue
        data = T(jsonData["data"])
    }
}

struct BaseArrayResponse <T: SwiftJSONModelAble>: SwiftJSONModelAble {
    
    var code: Int
    var data: [T]
    var message: String
    var requestId: String
    
    init(_ jsonData: JSON) {
        code = jsonData["code"].intValue
        message = jsonData["message"].stringValue
        requestId = jsonData["requestId"].stringValue
        data = jsonData["data"].arrayValue.compactMap({ T($0) })
    }
}

struct JSONData: SwiftJSONModelAble {
    let data: Any
    init(_ jsonData: JSON) {
        data = jsonData.rawValue
    }
}
