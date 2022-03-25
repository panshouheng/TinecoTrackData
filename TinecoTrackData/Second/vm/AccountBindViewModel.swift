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
    let refreshSubject = PublishSubject<MJRefreshAction>()
    let deviceData = BehaviorRelay<[BindDeviceModel]>(value: [])
    let productData = BehaviorRelay<[BindProductModel]>(value: [])
    let snCodeDevices = BehaviorRelay<[SnCodeModel]>(value: [])
    
    private lazy var deviceDataRequest: Observable<BaseArrayResponse<BindDeviceModel>> = {
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
    
    init(input: String, pageType: PageType, refresh: Observable<Void>) {
        self.input = input
        self.pageType = pageType
        
        refresh.subscribe { [weak self] _ in
            switch pageType {
            case .BindDevice:
                self?.requestDevice()
            case .BindProduct:
                self?.requestProduct()
            case .BluetoothSnCode, .WifiSnCode:
                self?.requestSnCodeDevices()
            }
        }.disposed(by: bag)
        
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
        self.deviceDataRequest.subscribe {[weak self] event in
            guard let resp = event.element else { return  }
            self?.deviceData.accept(resp.data)
            self?.refreshSubject.onNext(.stopRefresh)
        }.disposed(by: bag)
    }
    
    func requestProduct() {
        self.productDataRequest.subscribe {[weak self] event in
            guard let resp = event.element else { return  }
            self?.productData.accept(resp.data)
            self?.refreshSubject.onNext(.stopRefresh)
        }.disposed(by: bag)
    }
    
    func requestSnCodeDevices() {
        self.snCodeDevicesRequest.subscribe {[weak self] event in
            guard let resp = event.element else { return  }
            self?.snCodeDevices.accept(resp.data)
            self?.refreshSubject.onNext(.stopRefresh)
        }.disposed(by: bag)
    }
    
    deinit {
        TLLog("销毁了")
    }
}
