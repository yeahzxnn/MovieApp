//
//  MobileOrderViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//

import Foundation
import UIKit

class MobileOrderViewController: MainViewController {
    
    // UI 연결
    @IBOutlet weak var forRadius1: UIView!
    @IBOutlet weak var forRadius2: UIView!
    
    @IBOutlet weak var userInfoButton: UIButton!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Radius 설정
        addRadiusToUIView(forRadius1, radiusSize: 10)
        addRadiusToUIView(forRadius2, radiusSize: 10)
        
        
        navigationController?.isNavigationBarHidden = true
        userInfoButton.addTarget(self, action: #selector(showUserDetail), for: .touchUpInside)
    }
}
