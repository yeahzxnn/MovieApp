//
//  MainViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//

import Foundation
import UIKit


class MainViewController: UIViewController {
    
    // 사용자 정보
    static var isUserLogin: Bool = false
    static var userNickName: String = "OOO"
    
    
    // 사용자 Model
    var userModel: UserList = UserList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - UI 함수
    
    // 둥글게 + 테두리
    func addBorderRadiusToUIView(_ view: UIView, radiusSize: CGFloat, borderColor: CGColor) {
        view.layer.cornerRadius = radiusSize
        view.layer.borderColor = borderColor
        view.layer.borderWidth = 1
    }
    
    // 둥글게
    func addRadiusToUIView(_ view: UIView, radiusSize: CGFloat) {
        view.layer.cornerRadius = radiusSize
    }
    
    
    
    // 위에만 둥글게
    func addRadiusToUIViewTop(_ view: UIView, radiusSize: CGFloat) {
        view.layer.cornerRadius = radiusSize
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    
    // 그림자
    func addShadow(_ to: UIView, color: CGColor, width: CGFloat, height: CGFloat, alpha: Float, radius: CGFloat) {
            to.layer.shadowColor = color
            to.layer.shadowOpacity = alpha
            to.layer.shadowRadius = radius
            to.layer.shadowOffset = CGSize(width: width, height: height)
            to.layer.shadowPath = nil
        }
    
    
    
    
    
    // MARK: - 숫자 콤마찍어서 반환
    func DecimalPoint(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + "P"
            return result
    }
    
    
    
    
    
    
    // MARK: - objc 함수
    @objc func showUserDetail() {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailInfoViewController") as? DetailInfoViewController else {
            return
        }
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
