//
//  AttractionModel.swift
//  TravelApp
//
//  Created by Onur Duyar on 23.06.2023.
//

import Foundation

struct AttractionModel: Decodable {
    let data: [Attraction]?
    let paging: Paging?

    enum CodingKeys: String, CodingKey {
        case data
        case paging
    }
}
struct Attraction: Decodable {
    let locationID, name, latitude, longitude: String?
    let photo: Photo?
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name, latitude, longitude, photo
    }
}
