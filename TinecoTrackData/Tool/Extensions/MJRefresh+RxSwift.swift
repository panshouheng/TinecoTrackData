//
//  MJRefresh+RxSwift.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/22.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa
 
class RxTarget: NSObject, Disposable {  // RxTarget 是 Rxswift 源码
    private var retainSelf: RxTarget?
    override init() {
        super.init()
        self.retainSelf = self
    }
    func dispose() {
        self.retainSelf = nil
    }
}
 
final class RefreshTarget<Component: MJRefreshComponent>: RxTarget {
    typealias Callback = MJRefreshComponentAction
    var callback: Callback?
    weak var component: Component?
 
    let selector = #selector(RefreshTarget.eventHandler)
 
    init(_ component: Component, callback: @escaping Callback) {
        self.callback = callback
        self.component = component
        super.init()
        component.setRefreshingTarget(self, refreshingAction: selector)
    }
    @objc func eventHandler() {
        if let callback = self.callback {
            callback()
        }
    }
    override func dispose() {
        super.dispose()
        self.component?.refreshingBlock = nil
        self.callback = nil
    }
}
 
extension Reactive where Base: MJRefreshComponent {
    var event: ControlEvent<Base> {
        let source: Observable<Base> = Observable.create { [weak control = self.base] observer  in
            MainScheduler.ensureExecutingOnScheduler()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }
            let observer = RefreshTarget(control) {
                observer.on(.next(control))
            }
            return observer
        }.take(until: deallocated)
        return ControlEvent(events: source)
    }
}
