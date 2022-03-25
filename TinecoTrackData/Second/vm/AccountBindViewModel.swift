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
    let pageType: PageType
    let headers = BehaviorRelay<[String]>(value: [])
    
    let deivceData = BehaviorRelay<[BindDeviceModel]>(value: [])
    let productData = BehaviorRelay<[BindProductModel]>(value: [])
    let snCodeDevices = BehaviorRelay<[SnCodeModel]>(value: [])
    
    private lazy var deivceDataRequest: Observable<BaseArrayResponse<BindDeviceModel>> = {
        AccountBindProvider
            .rx
            .request(.bindDevice(mobile: self.input))
            .asObservable()
            .mapModel(BaseArrayResponse<BindDeviceModel>.self)
            .catchAndReturn(BaseArrayResponse.init(JSON()))
    }()
    
    private lazy var productDataRequest: Observable<BaseArrayResponse<BindProductModel>> = {
        AccountBindProvider
            .rx
            .request(.bindProduct(mobile: self.input))
            .asObservable()
            .mapModel(BaseArrayResponse<BindProductModel>.self)
            .catchAndReturn(BaseArrayResponse.init(JSON()))
    }()
    private lazy var snCodeDevicesRequest: Observable<BaseArrayResponse<SnCodeModel>> = {
        AccountBindProvider
            .rx
            .request(self.pageType == .BluetoothSnCode ? .bluetoothSnCode(sn: self.input):.wifiSnCode(sn: self.input))
            .asObservable()
            .mapModel(BaseArrayResponse<SnCodeModel>.self)
            .catchAndReturn(BaseArrayResponse.init(JSON()))
    }()
    
    init(input: String, pageType: PageType) {
        self.input = input
        self.pageType = pageType
        switch pageType {
        case .BindDevice:
            headers.accept(["手机型号", "系统版本", "手机UUID", "应用版本号"])
            requestDevice()
        case .BindProduct:
            headers.accept(["名称", "type", "sn", "设备识别码"])
            requestProduct()
        case .BluetoothSnCode, .WifiSnCode:
            headers.accept(["账号", "手机型号", "系统版本", "手机UUID"])
            requestSnCodeDevices()
        }
        
        Reachability.rx.isConnected
            .subscribe(onNext: { [weak self] in
                print("Is connected")
                switch pageType {
                case .BindDevice:
                    self?.requestDevice()
                case .BindProduct:
                    self?.requestProduct()
                case .BluetoothSnCode, .WifiSnCode:
                    self?.requestSnCodeDevices()
                }
            })
            .disposed(by: bag)
        
    }
    
    func requestDevice() {
        self.deivceDataRequest.flatMapLatest { resp -> Observable<[BindDeviceModel]> in
            return Observable.create { ob in
                guard  resp.isOK else {  return Disposables.create { } }
                if resp.data.count == 0 { TLToast.show("暂无数据") }
                ob.onNext(resp.data)
                return Disposables.create {}
            }
        }.share(replay: 1).bind(to: self.deivceData).disposed(by: bag)
    }
    
    func requestProduct() {
        self.productDataRequest.flatMapLatest { resp -> Observable<[BindProductModel]> in
            return Observable.create { ob in
                guard  resp.isOK else { return Disposables.create { } }
                if resp.data.count == 0 { TLToast.show("暂无数据") }
                ob.onNext(resp.data)
                return Disposables.create {}
            }
        }.share(replay: 1).bind(to: self.productData).disposed(by: bag)
    }
    
    func requestSnCodeDevices() {
        self.snCodeDevicesRequest.flatMapLatest { resp -> Observable<[SnCodeModel]> in
            return Observable.create { ob in
                guard  resp.isOK else {  return Disposables.create { } }
                if resp.data.count == 0 { TLToast.show("暂无数据") }
                ob.onNext(resp.data)
                return Disposables.create {}
            }
        }.share(replay: 1).bind(to: self.snCodeDevices).disposed(by: bag)
    }
}
