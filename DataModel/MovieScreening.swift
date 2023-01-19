//
//  MovieScreening.swift
//  MovieApp
//
//  Created by 신예진 on 2023/01/19.
//

import Foundation

// MARK: - Empty
struct Empty: Codable {
    let movieScreening: [MovieScreening]

    enum CodingKeys: String, CodingKey {
        case movieScreening = "MovieScreening"
    }
}

// MARK: - MovieScreening
struct MovieScreening: Codable {
    let head: [Head]?
    let row: [Row]?
}

// MARK: - Head
struct Head: Codable {
    let listTotalCount: Int?
//    let result: []?
    let apiVersion: String?

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
//        case result = "RESULT"
        case apiVersion = "api_version"
    }
}

struct row: Codable {
 let BIZPLC_NM: String?
 let REFINE_WGS84_LOGT: String?
 let REFINE_WGS84_LAT: String?
}

//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
