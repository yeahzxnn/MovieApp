//
//  Movie.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/19.
//

import Foundation
import Foundation

struct Movie: Codable {
  let MovieScreening: [MovieScreening]
}
struct MovieScreening: Codable {
  let row: [Row]?
}

struct Row: Codable {
 let BIZPLC_NM: String?
 let REFINE_WGS84_LOGT: String?
 let REFINE_WGS84_LAT: String?
}
