//
//  LoginViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/15.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    let usernameTextField = UITextField.create(placeholder: "用户名")
    let passwordTextField = UITextField.create(placeholder: "密码")
    let sendButton = UIButton(type: .custom)
    var viewModel: LoginViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        
        view.addSubviews([usernameTextField, passwordTextField, sendButton])
        usernameTextField.keyboardType = .namePhonePad
        passwordTextField.isSecureTextEntry = true
        usernameTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(NAV_HEIGHT+100)
        }
        passwordTextField.snp.makeConstraints { make in
            make.left.right.height.equalTo(usernameTextField)
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
        }
        
        sendButton.setTitleForAllStates("登录")
        sendButton.backgroundColor = .blue
        sendButton.snp.makeConstraints { make in
            make.left.right.height.equalTo(usernameTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        
        viewModel = LoginViewModel(input: (username: usernameTextField.rx.text.orEmpty.asObservable(),
                                               password: passwordTextField.rx.text.orEmpty.asObservable(),
                                               loginTap: sendButton.rx.tap.asObservable()))
        viewModel?.signInEnabled
            .subscribe(onNext: { [weak self] valid  in
                self?.sendButton.isEnabled = valid
                self?.sendButton.alpha = valid ? 1.0 : 0.3
            }).disposed(by: rx.disposeBag)
        
        viewModel?.signedIn.subscribe { event in
            guard let res = event.element, res.isOK else { return  }
            let tabbar = MainTabBarController()
            UIApplication.shared.keyWindow?.rootViewController = tabbar
            
        }.disposed(by: rx.disposeBag)
    }
    deinit {
        TLLog("销毁了")
    }
}
