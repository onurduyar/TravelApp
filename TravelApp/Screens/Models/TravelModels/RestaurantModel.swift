//
//  RestaurantModel.swift
//  TravelApp
//
//  Created by Onur Duyar on 23.06.2023.
//

import Foundation

struct RestaurantModel: Decodable {
    let data: [Restaurant]?
    let paging: Paging?

    enum CodingKeys: String, CodingKey {
        case data
        case paging
    }
}

// MARK: - Datum
struct Restaurant: Decodable {
    let locationID, name, latitude, longitude: String?
    let numReviews, timezone, locationString: String?

    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name, latitude, longitude
        case numReviews = "num_reviews"
        case timezone
        case locationString = "location_string"
    }
}
