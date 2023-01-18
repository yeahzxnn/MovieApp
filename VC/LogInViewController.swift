//
//  ViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/17.
//

import UIKit
import Alamofire
import KakaoSDKUser
import KakaoSDKUser

class LogInViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
    }

    @IBAction func kakaoLoginTouched(_ sender: UIButton) {
      UserApi.shared.loginWithKakaoAccount() { (oAuthToken, error) in
        if let error = error {
          print(error)
        } else {
          print("loginWithKakaoAccount success")
            _ = oAuthToken
          guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC")
                  as? HomeViewController else { return }
          vc.modalPresentationStyle = .fullScreen
          self.present(vc, animated: true)
        }
      }
    }
        
}
