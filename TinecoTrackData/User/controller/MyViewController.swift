//
//  MyViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import UIKit

class MyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func changePassword(_ sender: Any) {
        let reset = ResetPasswordViewController()
        self.navigationController?.pushViewController(reset, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        User.delete()
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginViewController())
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
