//
//  UserInfoViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//

import UIKit
import KakaoSDKAuth

class UserInfoViewController: MainViewController {
    
    // 토큰 존재 여부 확인하는 버튼 : hasToken()
    @IBAction func userHasToken(_ sender: UIButton) {
        print(AuthApi.hasToken())
    }
    
    
    // UI 연결
    @IBOutlet weak var userInfoButton: UIButton!
    
    
    // 컨테이너 뷰
    @IBOutlet weak var beforeLoginContainerView: UIView!
    @IBOutlet weak var afterLoginContainerView: UIView!
    
    
    // 컨테이너 뷰 참조 얻은 변수
    var beforeVC: BeforeLoginContainerView?
    var afterVC: AfterLoginContainerView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        userInfoButton.addTarget(self, action: #selector(showUserDetail), for: .touchUpInside)
        
        beforeVC?.userInfoVC = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // 사용자의 로그인 여부에 따라 다른 ContainerView 보여주기
        if MainViewController.isUserLogin {
            beforeLoginContainerView.isHidden = true
        }
    }
    
    
    
    // 컨테이너뷰 참조 얻기
    // beforeSegue
    // afterSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let beforeVC as BeforeLoginContainerView:
            self.beforeVC = beforeVC
            
        case let afterVC as AfterLoginContainerView:
            self.afterVC = afterVC
            
        default:
            break
        }
    }
}
