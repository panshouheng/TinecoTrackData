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
import RxReachability
import Reachability

enum PageType {
    case BindDevice
    case BindProduct
    case BluetoothSnCode
    case WifiSnCode
}
class AccountBindViewModel {
    
    private let bag = DisposeBag()
    private let input: String
    private let pageType: PageType
    private lazy var deviceDataRequest: Observable<BaseArrayResponse<BindDeviceModel>> = {
        self.initRequst(.bindDevice(mobile: input), modelType: BindDeviceModel.self)
    }()
    private lazy var productDataRequest: Observable<BaseArrayResponse<BindProductModel>> = {
        self.initRequst(.bindProduct(mobile: input), modelType: BindProductModel.self)
    }()
    private lazy var snCodeDevicesRequest: Observable<BaseArrayResponse<SnCodeModel>> = {
        self.initRequst(pageType == .BluetoothSnCode ? .bluetoothSnCode(sn: input):.wifiSnCode(sn: input), modelType: SnCodeModel.self)
    }()
    
    /// header的titles
    let headers = BehaviorRelay<[String]>(value: [])
    /// 刷新状态
    let refreshState = PublishSubject<MJRefreshAction>()
    /// 请求数据
    let refreshData = BehaviorRelay<[DataFormatterModel]>(value: [])
    
    init(input: String, pageType: PageType, refresh: Observable<Void>) {
        self.input = input
        self.pageType = pageType
        
        self.getData()
        
        Reachability.rx.isConnected.subscribe { [unowned self] _ in
            self.getData()
        }.disposed(by: bag)
        
        refresh.subscribe { [unowned self] _ in
            self.getData()
        }.disposed(by: bag)
        
    }
    
    func getData() {
        switch pageType {
        case .BindDevice:
            headers.accept(["手机型号", "系统版本", "手机UUID", "应用版本号"])
            requestData(abserver: deviceDataRequest)
        case .BindProduct:
            headers.accept(["名称", "type", "sn", "设备识别码"])
            requestData(abserver: productDataRequest)
        case .BluetoothSnCode, .WifiSnCode:
            headers.accept(["账号", "手机型号", "系统版本", "手机UUID"])
            requestData(abserver: snCodeDevicesRequest)
        }
    }
    
    deinit {
        TLLog("销毁了")
    }
}
extension AccountBindViewModel {
    
    func initRequst<T: SwiftJSONModelAble>(_ target: AccountBindTarget, modelType: T.Type) -> Observable<BaseArrayResponse<T>> {
        AccountBindProvider
            .rx
            .request(target)
            .asObservable()
            .mapModel(BaseArrayResponse<T>.self)
            .catchAndReturn(BaseArrayResponse.init(JSON()))
    }
    
    func requestData<T: SwiftJSONModelAble>(abserver: Observable<BaseArrayResponse<T>>) {
        
        abserver.subscribe {[weak self] event in
            guard let resp = event.element else { return  }
            var fomatter = [DataFormatterModel]()
            
            if T.self == BindDeviceModel.self {
                let data = resp.data as! [BindDeviceModel]
                data.forEach { model in
                    let m = DataFormatterModel(first: model.model, second: model.systemVersion, third: model.deviceNum, forth: model.appVersion)
                    fomatter.append(m)
                }
            } else if T.self == BindProductModel.self {
                let data = resp.data as! [BindProductModel]
                data.forEach { model in
                    let m = DataFormatterModel(first: model.nickname, second: model.type, third: model.snCode, forth: model.productId)
                    fomatter.append(m)
                }
            } else if T.self == BindProductModel.self {
                let data = resp.data as! [BindProductModel]
                data.forEach { model in
                    let m = DataFormatterModel(first: model.nickname, second: model.type, third: model.snCode, forth: model.productId)
                    fomatter.append(m)
                }
            }
            self?.refreshData.accept(fomatter)
            self?.refreshState.onNext(.stopRefresh)
        }.disposed(by: bag)
    }
}
