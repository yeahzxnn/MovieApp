//
//  ViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/17.
//

import UIKit
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class ViewController: UIViewController {
//    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func kakaoLoginButtonTouchUpInside(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                }
            }
        }
    }
    
}
//    //폰(시뮬레이터)에 앱이 안깔려 있을때 웹 브라우저를 통해 로그인
//    @IBAction func onKakaoLoginByWebTouched(_ sender: Any) {
//        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("loginWithKakaoAccount() success.")
//
//                //do something
//                _ = oauthToken
//                // 어세스토큰
//                let accessToken = oauthToken?.accessToken
//
//                //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
//                self.setUserInfo()
//            }
//        }
//    }
//
//    func setUserInfo() {
//        UserApi.shared.me() {(user, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("me() success.")
//                //do something
//                _ = user
//                self.infoLabel.text = user?.kakaoAccount?.profile?.nickname
//
//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    self.profileImageView.image = UIImage(data: data)
//                }
//            }
//        }
//    }

