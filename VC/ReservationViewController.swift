//
//  ReservationViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//

import Foundation
import UIKit

class ReservationViewController: MainViewController {
    
    
    // MARK: - UI 연결
    @IBOutlet weak var forRadius1: UIView!
    @IBOutlet weak var forRadius2: UIView!
    @IBOutlet weak var forRadius3: UIView!
    @IBOutlet weak var forRadius4: UIView!
    
    
    @IBOutlet weak var forShadow1: UIView!
    @IBOutlet weak var forShadow2: UIView!
    
    @IBOutlet weak var userInfoButton: UIButton!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Radius 설정
        addRadiusToUIView(forRadius1, radiusSize: forRadius1.frame.height/2)
        addRadiusToUIView(forRadius2, radiusSize: forRadius2.frame.height/2)
        addRadiusToUIView(forRadius3, radiusSize: forRadius3.frame.height/2)
        addRadiusToUIView(forRadius4, radiusSize: forRadius4.frame.height/2)
        
        // Shadow + Radius 설정
        addRadiusToUIView(forShadow1, radiusSize: 5)
        addRadiusToUIView(forShadow2, radiusSize: 5)
        addShadow(forShadow1, color: UIColor.black.cgColor, width: 2, height: 5, alpha: 0.3, radius: 30)
        addShadow(forShadow2, color: UIColor.black.cgColor, width: 2, height: 5, alpha: 0.3, radius: 30)
        
        
        navigationController?.isNavigationBarHidden = true
        userInfoButton.addTarget(self, action: #selector(showUserDetail), for: .touchUpInside)
    }
}
