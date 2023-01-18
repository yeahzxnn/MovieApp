//
//  HomeViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//

import Foundation
import UIKit
import Alamofire


class ViewController: MainViewController {
    
    // MARK: - Model 연결
    var eventListModel: EventList = EventList()
    var hashTagModel: HashTagList = HashTagList()
    var eventTagModel: EventTagList = EventTagList()
    var specialHallModel: SpecialHallList = SpecialHallList()
    
    
    // MARK: - UI연결
    
    // 상단 이벤트 컬렉션뷰
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    // 해시태그 컬렉션뷰
    @IBOutlet weak var hashTagCollectionView: UICollectionView!
    
    // 영화 리스트 상단 라운딩 주려고 연결
    @IBOutlet weak var movieListUIView: UIView!
    
    // 박스오피스/상영예정 컨테이너 뷰
    @IBOutlet weak var boxOfficeContainerView: UIView!
    @IBOutlet weak var comingSoonContainerView: UIView!
    

    // 이벤트 태그 리스트
    @IBOutlet weak var eventTagCollectionView: UICollectionView!
    
    // 매가픽 / 영화 컨테이너 뷰
    @IBOutlet weak var megaPickContainerView: UIView!
    @IBOutlet weak var movieContainerView: UIView!
    
    
    // 특별관 컬렉션뷰
    @IBOutlet weak var specialHallCollectionView: UICollectionView!

    
    // 유저정보 버튼
    @IBOutlet weak var userInfoButton: UIButton!
    
    
    
    
    // MARK: - container view 연결
    var boxOfficeContainerVC: BoxOfficeContainerView?
    var comingSoonContainerVC: ComingSoonContainerView?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let boxOfficeVC as BoxOfficeContainerView:
            self.boxOfficeContainerVC = boxOfficeVC
            
        case let comingSoonVC as ComingSoonContainerView:
            self.comingSoonContainerVC = comingSoonVC
            
        default:
            break
        }
    }
    
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이벤트 컬렉션뷰 설정
        eventCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewSetting(eventCollectionView, nib: "EventCollectionViewCell")
        eventCollectionView.collectionViewLayout = createCompositionalLayout()

        // 해시태그 컬렉션뷰 설정
        hashTagCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewSetting(hashTagCollectionView, nib: "HashTagCollectionViewCell")

        // 이벤트 태그 컬렉션뷰 설정
        eventTagCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        eventTagCollectionView.delegate = self
        eventTagCollectionView.dataSource = self
        eventTagCollectionView.register(UINib(nibName: "HashTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HashTagCollectionViewCell")
        
        // 특별관 컬렉션뷰 설정
        specialHallCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewSetting(specialHallCollectionView, nib: "SpecialHallCollectionViewCell")
        specialHallCollectionView.collectionViewLayout = createCompositionalLayout()
        
        
        
        // API 데이터를 가져오는 함수 (탈출 클로저로 값이 넘어오면 CollectionView 리로드)
        MovieRequest().getMovieData(completion: { [weak self] in
            // 여기서 각 컨테이너뷰들의 CollectionView를 리로드 시켜주면 됨!
            self!.boxOfficeContainerVC?.boxOfficeCollectionView.reloadData()
            //comingSoonContainerVC --> 여긴 개봉예정 VC 내부에 컬렉션뷰 완성 후 다시 작성
            
            
            // 박스오피스가 다 입력되면 forEach문 boxOfficeMovieTitles 변수에 제목만 저장
            MovieRequest.apiData?.forEach({
                // optional배열에 append를 바로 해주면 값이 들어가지 않아서 조건문을 통해 배열이 nil일 경우 값을 직접 할당
                if (self!.boxOfficeMovieTitles?.append($0.movieNm)) == nil {
                    self!.boxOfficeMovieTitles = [$0.movieNm]
                }
                print($0.movieNm)
            })
            
            
        })
        
        
        // 영화 리스트들 위쪽만 Radius주기
        addRadiusToUIViewTop(hashTagCollectionView, radiusSize: 20)
        
        
        // 유저정보 버튼 addTarget & 네이게이션 설정
        navigationController?.isNavigationBarHidden = true
        userInfoButton.addTarget(self, action: #selector(showUserDetail), for: .touchUpInside)
    }
    
    
    
    
    // MARK: - 함수들
    func collectionViewSetting(_ collectionView: UICollectionView, nib: String) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: nib, bundle: nil), forCellWithReuseIdentifier: nib)
    }
    
    
    
    // MARK: - 변수들
    // 박스오피스 영화 제목 가져올 배열
    var boxOfficeMovieTitles: [String]? {
        didSet {
            if boxOfficeMovieTitles?.count == 10 {
                SearchRequest().getMovieData(movieTitles: boxOfficeMovieTitles!, completion: {
                    // 여기서는 SearchRequest()의 static 배열 변수를 사용하여 컨테이너뷰->컬렉션뷰의 이미지뷰 값을 수정
                    self.boxOfficeContainerVC?.boxOfficeCollectionView.reloadData()
                    //comingSoonContainerVC --> 여긴 개봉예정 VC 내부에 컬렉션뷰 완성 후 다시 작성
                })
            }
        }
    }
}



// MARK: - CollectionView 프로토콜 채택

// 하나의 VC내부에 여러 collectionView가 들어오니까 조건문을 통해 구분 적용
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 이벤트 컬렉션뷰
        if collectionView == eventCollectionView {
            return eventListModel.count
        }
        if collectionView == hashTagCollectionView {
            return hashTagModel.count
        }
        if collectionView == eventTagCollectionView {
            return eventTagModel.count
        }
        if collectionView == specialHallCollectionView {
            return specialHallModel.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 이벤트 컬렉션뷰
        if collectionView == eventCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateCell(eventListModel.getEventData(indexPath.row))
            return cell
        }
        // 해시태그 컬렉션뷰
        if collectionView == hashTagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCollectionViewCell", for: indexPath) as? HashTagCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateCell(hashTagModel.getHashTag(indexPath.row))
            if indexPath.row == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
            return cell
        }
        // 이벤트 태그 컬렉션뷰
        if collectionView == eventTagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCollectionViewCell", for: indexPath) as? HashTagCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateCell(eventTagModel.getEventTag(indexPath.row))
            if indexPath.row == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
            return cell
        }
        // 특별관 컬렉션뷰
        if collectionView == specialHallCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialHallCollectionViewCell", for: indexPath) as? SpecialHallCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateCell(specialHallModel.getSpecialHallInfo(indexPath.row))
            
            return cell
        }
        
        
        
        return UICollectionViewCell()
    }
    
    
    // 셀이 선택되면 컨테이너뷰 isHidden 컨트롤
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)번째 셀 선택")
        // 여기서 스위치로 0번째가 눌리면 컨테이너뷰 히든 트루펄스 설정해주면 될듯
        if collectionView == hashTagCollectionView {
            if indexPath.row == 0 {
                boxOfficeContainerView.isHidden = false
                comingSoonContainerView.isHidden = true
            }else {
                boxOfficeContainerView.isHidden = true
                comingSoonContainerView.isHidden = false
            }
        }
        if collectionView == eventTagCollectionView {
            if indexPath.row == 0 {
                megaPickContainerView.isHidden = false
                movieContainerView.isHidden = true
            }else {
                megaPickContainerView.isHidden = true
                movieContainerView.isHidden = false
            }
        }
    }
}



// MARK: - 컴포지셔널 컬렉션뷰 레이아웃 잡는 함수 작성
extension ViewController {
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
            
        // 컴포지셔널 레이아웃 생성
        // 생성하면 튜플(key: value, key: value)의 묶음으로 들어옴. 반환하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
        let layout = UICollectionViewCompositionalLayout {
            // 매개변수와 반환타입 (내부에서 섹션을 구성하고 완성된 섹션을 반환하는 것)
            (sectionIndex: Int, layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                
            // 아이템에 대한 사이즈
            // absolute: 고정값, estimateed: 추측, fraction: 퍼센트(내 화면에서 얼마만큼 설정할건가.. 뭐 그런거)
            // fraction은 상위View를 기준으로 퍼센트 잡는듯 (ex- 아이템은 그룹 사이즈를 기준으로 % 잡는듯)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
                
            // 그룹 사이즈
            let groubSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1/3))
                
            // 그룹사이즈로 그룹 만들기 (horizontal, vertical 선택 가능)
            let groub = NSCollectionLayoutGroup.horizontal(layoutSize: groubSize, subitem: item, count: 4)
                
            // 그룹간의 간격 설정
            //groub.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: groub)
                
            // 섹션 내부의 그룹들을 스크롤 가능하게 하는 코드 (continuous = 일반 스크롤, pagin = 그룹별로 스크롤)
            section.orthogonalScrollingBehavior = .continuous
                
            // 섹션에 대한 간격 설정
//            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
            return section
        }
            
        return layout
    }
}



// 에러메시지 겁나 나와서 구글링을 통해 복붙한 코드 (나중에 심심하면 찾아봐야...지)
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 15, height: collectionView.frame.width/9)
    }
}
