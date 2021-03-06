//
//  LoginViewModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/18.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
class LoginViewModel {
    
    let validatedUsername: Observable<Bool>
    let validatedPassword: Observable<Bool>
    
    let signInEnabled: Observable<Bool>
    let signedIn: Observable<BaseResponse<User>>
    
    init(input:(username: Observable<String>,
                password: Observable<String>,
                loginTap: Observable<Void>)
    ) {
        validatedUsername = input.username.map { $0.count > 4 }.share(replay: 1)
        validatedPassword = input.password.map { $0.count > 5 }.share(replay: 1)
        signInEnabled = Observable.combineLatest(validatedUsername, validatedPassword) { $0 && $1 }.distinctUntilChanged().share(replay: 1)
        
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        signedIn = input.loginTap.withLatestFrom(usernameAndPassword)
            .flatMapLatest { (username: String, password: String) in
                return UserProvider.rx
                    .request(.login(username: username, password: password))
                    .retry(1)
                    .asObservable()
                    .mapModel(BaseResponse<User>.self)
                    .catchAndReturn(BaseResponse.init(JSON()))
            }
            .flatMapLatest { response -> Observable<BaseResponse<User>> in
                return Observable.create { ob in
                    guard  response.isOK else {
                        if response.code.contains("U") {
                            TLToast.show(response.message)
                        }
                        return Disposables.create { }

                    }
                    response.data.save()
                    ob.onNext(response)
                    return Disposables.create { }
                }
            }.share(replay: 1)
    }
    deinit {
        TLLog("销毁了")
    }
    
}
