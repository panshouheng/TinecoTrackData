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
        
        let viewModel = LoginViewModel(input: (username: usernameTextField.rx.text.orEmpty.asObservable(),
                                               password: passwordTextField.rx.text.orEmpty.asObservable(),
                                               loginTap: sendButton.rx.tap.asObservable()))
        viewModel.signupEnabled
            .subscribe(onNext: { [weak self] valid  in
                self?.sendButton.isEnabled = valid
                self?.sendButton.alpha = valid ? 1.0 : 0.3
            }).disposed(by: rx.disposeBag)
        
        viewModel.signedIn.subscribe { event in
            guard let res = event.element, res.isOK else { return  }
            let tabbar = MainTabBarController()
            UIApplication.shared.keyWindow?.rootViewController = tabbar
            
        }.disposed(by: rx.disposeBag)
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

extension UITextField {
    static func create(placeholder: String?) -> UITextField {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.placeholder = placeholder
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 18)
        return tf
    }
}
