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
class ResetPasswordViewModel {
    
    let validatedUsername: Observable<Bool>
    let validatedPassword: Observable<Bool>
    let validatedNewPassword: Observable<Bool>
    
    let sendEnabled: Observable<Bool>
    let sendFinish: Observable<BaseResponse<User>>
    
    static  let userProvider = MoyaProvider<UserTarget>.initProvider()
    
    init(input:(username: Observable<String>,
                password: Observable<String>,
                newpassword: Observable<String>,
                sendTap: Observable<Void>)
    ) {
        validatedUsername = input.username.map { $0.count > 3 }.share(replay: 1)
        validatedPassword = input.password.map { $0.count > 3 }.share(replay: 1)
        validatedNewPassword = input.newpassword.map { $0.count > 3 }.share(replay: 1)
        sendEnabled = Observable.combineLatest(validatedUsername, validatedPassword, validatedNewPassword) { $0 && $1 && $2 }.distinctUntilChanged().share(replay: 1)
        
        let paramObserver = Observable.combineLatest(input.username, input.password, input.newpassword) { (username: $0, password: $1, newpassword:$2) }
        sendFinish = input.sendTap.withLatestFrom(paramObserver)
            .flatMapLatest { (username: String, password: String, newpassword: String) in
                return UserProvider.rx
                    .request(.repassword(username: username, password: password, newPassword: newpassword))
                    .retry(1)
                    .asObservable()
                    .mapModel(BaseResponse<User>.self)
                    .catchAndReturn(BaseResponse.init(JSON()))
            }
            .flatMapLatest { response -> Observable<BaseResponse<User>> in
                return Observable.create { ob in
                    guard  response.isOK else {
                        if ["U10001", "U10002"].contains(response.code) {
                            TLToast.show(response.message)
                        }
                        return Disposables.create { }
                    }
                    User.delete()
                    ob.onNext(response)
                    return Disposables.create { }
                }
            }.share(replay: 1)
    }
    
}
