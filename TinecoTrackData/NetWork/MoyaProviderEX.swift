//
//  APIProvider.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/15.
//

import Foundation
import Moya
import RxSwift

extension MoyaProvider {
    static func initProvider() -> MoyaProvider<Target> {
        let plugins = [
            NetworkActivityPlugin(networkActivityClosure: { change, _ in
                switch change {
                case .began: TLToast.loading()
                case .ended: TLToast.dismiss()
                }
            })
        ]
        let provider = MoyaProvider<Target>.init(requestClosure: { endPoint, closure in
            do {
                var urlRequest = try endPoint.urlRequest()
                urlRequest.timeoutInterval = 15
                closure(.success(urlRequest))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }, plugins: plugins )
        return provider
    }
}
