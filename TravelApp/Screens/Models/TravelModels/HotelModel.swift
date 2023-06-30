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
    let photo: Photo?
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name, latitude, longitude,photo
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

struct Photo: Decodable {
    let images: Images?
    let isBlessed: Bool?
    let caption, id, helpfulVotes: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case images
        case isBlessed = "is_blessed"
        case caption, id
        case helpfulVotes = "helpful_votes"
        case user
    }
}
struct Images: Decodable {
    let small, thumbnail, original, large: Large?
    let medium: Large?
}
struct Large: Decodable {
    let width: String?
    let url: String?
    let height: String?
}
struct User: Decodable {
    let memberID, type: String?

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case type
    }
}
