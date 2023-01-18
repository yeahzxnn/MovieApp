//
//  StoreViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//


import Foundation
import UIKit

class StoreViewController: MainViewController {
    
    // cell 사이즈 변수
    let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    
    // UI 연결
    @IBOutlet weak var storeCollectionView: UICollectionView!
    
    @IBOutlet weak var userInfoButton: UIButton!
    
    
    
    
    // Model 연결
    var productModel: ProductModel = ProductModel()
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션뷰 설정
        storeCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        storeCollectionView.collectionViewLayout = createCompositionalLayout()
        storeCollectionView.delegate = self
        storeCollectionView.dataSource = self
        storeCollectionView.register(UINib(nibName: "StoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoreCollectionViewCell")
        storeCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        
        
        navigationController?.isNavigationBarHidden = true
        userInfoButton.addTarget(self, action: #selector(showUserDetail), for: .touchUpInside)
    }
}






// MARK: - Delegate, Datasource 프로토콜 채택
extension StoreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productModel.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCollectionViewCell", for: indexPath) as? StoreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.cellUpdate(productModel.getProductImage(indexPath.row))
        
        return cell
    }
    
    
    
    // 컬렉션뷰 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = storeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath)
            return header
        }else {
            return UICollectionReusableView()
        }
    }
}






// MARK: - DelegateFlowLayout 프로토콜 채택 : Header 높이 설정
extension StoreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width*1.7)
    }
    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width
            let height = collectionView.frame.width * 4
            let itemsPerRow: CGFloat = 2
            let widthPadding = sectionInsets.left * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 4
            let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            return CGSize(width: cellWidth, height: cellHeight)
            
        }
    
}

