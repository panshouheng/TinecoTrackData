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
                TLToast.show(response.debugDescription)
                throw RxSwiftJSONError(domain: response.description, code: response.statusCode, message: response.debugDescription)
            }
            guard let jsonData = try? resp.mapJSON() else {
                TLToast.show("数据转json失败")
                throw RxSwiftJSONError(domain: "mapJSON error", code: -1, message: "数据转json失败")
            }
            let object = T(JSON(jsonData))
            TLLog(jsonData)
            return Observable.just(object)
        }
    }
}
