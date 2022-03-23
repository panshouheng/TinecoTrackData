//
//  BindProductModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import Foundation

struct BindProductModel: SwiftJSONModelAble {
    
    let nickname: String
    let productId: String
    let type: String
    let snCode: String
    
    init(_ jsonData: JSON) {
        nickname = jsonData["nickname"].stringValue
        productId = jsonData["productId"].stringValue
        type = jsonData["type"].stringValue
        snCode = jsonData["snCode"].stringValue
    }
}
