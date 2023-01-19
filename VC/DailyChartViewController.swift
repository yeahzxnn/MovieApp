//
//  DailyChartViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/19.
//

import Foundation
import UIKit
import Alamofire

class DailyChartViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var dailyMovieCollectionView: UICollectionView!
  var dailyBoxOfficeList: [DailyBoxOfficeList] = []
  var movieInfo: MovieInfo?
  
  // MARK:- Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    getDailyMovie()
    dailyMovieCollectionView.dataSource = self
    dailyMovieCollectionView.delegate = self
   
  }
  
  private func getDailyMovie() {
    var url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=ce892e04c95cefd2f26f5dfdd9912c68&targetDt="
    url += getYesterdayString()
    print(url)
    AF.request(url).responseJSON { (response) in
      switch response.result {
      case.success(let data):
        do {
          let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
          let json = try JSONDecoder().decode(DailyChart.self, from: jsonData)
          self.DailyBoxOfficeList = json.BoxOfficeResult.DailyBoxOfficeList
         
          // collectionView reloadData
          DispatchQueue.main.async {
            self.dailyMovieCollectionView.reloadData()
          }
        } catch(let error) {
          print(error.localizedDescription)
        }
      case .failure(let error):
        print("failure \(error.localizedDescription)")
      }
    }
  }
    
  private func getDetailMovie(movieCd: String) {
    let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=ce892e04c95cefd2f26f5dfdd9912c68&movieCd=\(movieCd)"
   
    AF.request(url).responseJSON{ (response) in
      switch response.result {
      case.success(let data):
        do {
          let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
          let json = try JSONDecoder().decode(DetailMovie.self, from: jsonData)
          let movieInfo = json.movieInfoResult.movieInfo
         
          // DetailMovieViewController 데이터 전달
          guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailMovieVC")
                  as? DetailMovieViewController else { return }
          vc.movieInfo = movieInfo
          vc.modalPresentationStyle = .fullScreen
          self.present(vc, animated: true, completion: nil)
          
        } catch(let error) {
          print(error.localizedDescription)
        }
      case .failure(let error):
        print("failure \(error.localizedDescription)")
      }
    }
  }
  
  // 어제 날짜 string으로 가져옴
  private func getYesterdayString() -> String {
    guard let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return "" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYYMMdd"
    let str = dateFormatter.string(from: yesterDay)
    return str
  }
}

// MARK: - UICollectionViewDataSource
extension DailyChartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dailyBoxOfficeList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = dailyMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "dailyChartCell", for: indexPath)
            as? DailyChartCollectionViewCell else { return UICollectionViewCell() }
    cell.audiAccLabel.text = "누적 \(dailyBoxOfficeList[indexPath.row].audiAcc)명"
    cell.titleLabel.text = dailyBoxOfficeList[indexPath.row].movieNm
    cell.rankLabel.text = dailyBoxOfficeList[indexPath.row].rank
    cell.salesLabel.text = "\(dailyBoxOfficeList[indexPath.row].salesShare)%"
    cell.posterImageView.layer.cornerRadius = 10
    if let image = UIImage(named: DailyBoxOfficeList[indexPath.row].movieCd) {
      cell.posterImageView.image = image
    }
    return cell
    
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movieCd = DailyBoxOfficeList[indexPath.row].movieCd
    getDetailMovie(movieCd: movieCd)
  }
  
}
