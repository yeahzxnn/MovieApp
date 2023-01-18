//
//  MoviewInfoViewController.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/18.
//

import Foundation
import UIKit


class MovieInfoViewController: MainViewController {
    
    // UI 연결
    @IBAction func popButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // API UI 연결
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var englishTitle: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var openDate: UILabel!
    
    @IBOutlet weak var director: UILabel!
    
    @IBOutlet weak var actor: UILabel!
    
    @IBOutlet weak var dailyAudience: UILabel!
    
    @IBOutlet weak var audienceChange: UILabel!
    
    @IBOutlet weak var accAudience: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // 탭바 히든 true/false
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func updateUI(url: String, title: String, enTitle: String, rank: String, ratingP: String, openDT: String, director: String, actor: String, accAu: String, dyAu: String, auCh: String) {
        let url = URL(string: url)
        let data = try! Data(contentsOf: url!)
        posterImage.image = UIImage(data: data)
        
        movieTitle.text = title
        englishTitle.text = enTitle
        ratingLabel.text = "\(rank)위"
        rating.text = ratingP
        openDate.text = openDT
        self.director.text = director
        self.actor.text = actor
        accAudience.text = "\(accAu)명"
        dailyAudience.text = "\(dyAu)명"
        audienceChange.text = "\(auCh)%"
    }
}
