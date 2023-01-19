//
//  DailyChart.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/19.
//


import Foundation

//struct Movie: Codable {
//  let MovieScreening: [MovieScreening]
//}
//
//struct MovieScreening: Codable {
//  let row: [Row]
//}

struct Row: Codable {
 let BIZPLC_NM: String?
 let REFINE_WGS84_LOGT: String?
 let REFINE_WGS84_LAT: String?
}

//// MARK: - Empty
//struct Empty: Codable {
//    let boxOfficeResult: BoxOfficeResult
//}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCD : String
    let movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = " "
        case movieNm, openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }
}

enum RankOldAndNew: String, Codable {
    case old = "OLD"
}

