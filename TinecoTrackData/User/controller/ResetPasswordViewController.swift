//
//  ResetPasswordViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/16.
//

import UIKit
import RxSwift

class ResetPasswordViewController: BaseViewController {
    
    let usernameTextField = UITextField.create(placeholder: "用户名")
    let passwordTextField = UITextField.create(placeholder: "密码")
    let newpasswordTextField = UITextField.create(placeholder: "新密码")
    let sendButton = UIButton(type: .custom)
    var viewModel: ResetPasswordViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改密码"
        
        view.addSubviews([usernameTextField, passwordTextField, newpasswordTextField, sendButton])
        usernameTextField.keyboardType = .namePhonePad
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
        newpasswordTextField.snp.makeConstraints { make in
            make.left.right.height.equalTo(usernameTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
        }
        sendButton.setTitleForAllStates("确认修改")
        sendButton.backgroundColor = .blue
        sendButton.snp.makeConstraints { make in
            make.left.right.height.equalTo(usernameTextField)
            make.top.equalTo(newpasswordTextField.snp.bottom).offset(20)
        }
        
        viewModel = ResetPasswordViewModel(input: (username: usernameTextField.rx.text.orEmpty.asObservable(),
                                                            password: passwordTextField.rx.text.orEmpty.asObservable(),
                                                            newpassword: newpasswordTextField.rx.text.orEmpty.asObservable(),
                                                       sendTap: sendButton.rx.tap.asObservable()))
        
        viewModel?.sendEnabled.subscribe(onNext: { [weak self] valid  in
            self?.sendButton.isEnabled = valid
            self?.sendButton.alpha = valid ? 1.0 : 0.3
        }).disposed(by: rx.disposeBag)
        
        viewModel?.sendFinish.subscribe { event in
            guard let res = event.element, res.isOK else { return  }
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }.disposed(by: rx.disposeBag)

    }
    
    deinit {
        TLLog("销毁了")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
