//
//  AccountBindViewModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

enum PageType {
    case BindDevice
    case BindProduct
}
class AccountBindViewModel {
    
    let mobile: String
    let pageType: PageType
    let headers = BehaviorRelay<[String]>(value: [])
    
    lazy var deivceData: Observable<[BindDeviceModel]> = {
      let  deivceData = AccountBindProvider
            .rx
            .request(.bindDevice(mobile: self.mobile))
            .asObservable()
            .mapModel(BaseArrayResponse<BindDeviceModel>.self)
            .catchAndReturn(BaseArrayResponse.init(JSON()))
            .flatMapLatest { resp -> Observable<[BindDeviceModel]> in
                return Observable.create { ob in
                    guard  resp.code == 200 else {  return Disposables.create { } }
                    if resp.data.count == 0 { TLToast.show("暂无数据") }
                    ob.onNext(resp.data)
                    return Disposables.create {}
                }
            }.share(replay: 1)
        return deivceData
    }()
    
    lazy var productData: Observable<[BindProductModel]> = {
        let productData = AccountBindProvider
            .rx
            .request(.bindProduct(mobile: self.mobile))
            .asObservable()
            .mapModel(BaseArrayResponse<BindProductModel>.self)
            .catchAndReturn(BaseArrayResponse.init(JSON()))
            .flatMapLatest { resp -> Observable<[BindProductModel]> in
                return Observable.create { ob in
                    guard  resp.code == 200 else { return Disposables.create { } }
                    if resp.data.count == 0 { TLToast.show("暂无数据") }
                    ob.onNext(resp.data)
                    return Disposables.create {}
                }
            }.share(replay: 1)
        return productData
    }()

    init(mobile: String, pageType: PageType) {
        self.mobile = mobile
        self.pageType = pageType
        
        switch pageType {
        case .BindDevice:
            headers.accept(["名称", "type", "sn", "设备识别码"])
        case .BindProduct:
            headers.accept(["手机型号", "系统版本", "手机UUID", "应用版本号"])
        }
    }
}
