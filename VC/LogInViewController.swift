//
//  ViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/17.
//

import Foundation
import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import SwiftUI

class LogInViewController: UIViewController {

    @IBOutlet weak var kakaoLoginButton: UIButton!
    lazy var KakaoAuthVM : KakaoAuthVM = {kakaoLogin_tutorial.KakaoAuthVM() }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kakaoLoginButton.setTitle("카카오 로그인", for:.normal)
    
    }

    @IBAction func loginBtnTabpped(_ sender: UIButton) {
        print("클릭됨")
        KakaoAuthVM.handleKakaoLogin()
    }
    
}
