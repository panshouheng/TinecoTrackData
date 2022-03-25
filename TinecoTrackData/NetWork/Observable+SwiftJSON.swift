//
//  Observable+SwiftJSON.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/14.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON

extension ObservableType where Element == Moya.Response {
    
    func mapModel<T: SwiftJSONModelAble>(_ type: T.Type) -> Observable<T> {
        flatMap { response -> Observable<T> in
            guard let resp = try? response.filterSuccessfulStatusCodes() else {
                if let data = response.data.string(encoding: String.Encoding.utf8), data.count>0 {
                    TLToast.show(data)
                } else {
                    TLToast.show("statusCode:\(response.statusCode)")
                }
                throw MoyaError.jsonMapping(response)
            }
            guard let jsonData = try? resp.mapJSON() else {
                TLToast.show("数据转json失败")
                throw MoyaError.jsonMapping(response)
            }
            let object = T(JSON(jsonData))
            TLLog(jsonData)
            return Observable.just(object)
        }
    }
}
