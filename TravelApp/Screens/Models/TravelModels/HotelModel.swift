//
//  HotelModel.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import Foundation

struct HotelModel: Decodable {
    let data: [Hotel]?
    let status: Status?
    let paging: Paging?
}
struct Hotel: Decodable {
    let locationID, name, latitude, longitude: String?
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name, latitude, longitude
    }
}
struct Paging: Decodable {
    let results, totalResults: String?

    enum CodingKeys: String, CodingKey {
        case results
        case totalResults = "total_results"
    }
}
struct Status: Decodable {
    let unfilteredTotalSize, commerceCountryISOCode: String?
    let autobroadened: Bool?
    let progress, auctionKey, primaryGeo, pricing: String?
    let doubleClickZone: String?

    enum CodingKeys: String, CodingKey {
        case unfilteredTotalSize = "unfiltered_total_size"
        case commerceCountryISOCode = "commerce_country_iso_code"
        case autobroadened, progress
        case auctionKey = "auction_key"
        case primaryGeo = "primary_geo"
        case pricing, doubleClickZone
    }
}
