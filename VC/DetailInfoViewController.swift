//
//  DetailInfoViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//

import Foundation
import UIKit

class DetailInfoViewController: MainViewController {
    
    // UI 연결
    @IBAction func didTouchedPopButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var toRadiusView: UIView!
    
    // 업데이트할 UI
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    
    // 위쪽만 Radius
    @IBOutlet weak var forRadiusView2: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Radius 추가
        addRadiusToUIViewTop(forRadiusView2, radiusSize: 20)
        addRadiusToUIView(toRadiusView, radiusSize: 20)
        
        
        let loginUserInfo: UserInfo = userModel.getUserInfo(MainViewController.userNickName)
        userNickName.text = "\(loginUserInfo.userName)님"
        pointLabel.text = DecimalPoint(value: loginUserInfo.point)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
}

