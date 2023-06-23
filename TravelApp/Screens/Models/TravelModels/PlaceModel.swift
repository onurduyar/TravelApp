//
//  PlaceModel.swift
//  TravelApp
//
//  Created by Onur Duyar on 23.06.2023.
//

import Foundation

struct PlaceModel: Codable {
    let type: String?
    let features: [Feature]?
}
struct Feature: Codable {
    let properties: Properties?
    let geometry: Geometry?
}
struct Geometry: Codable {
    let type: GeometryType?
    let coordinates: [Double]?
}
enum GeometryType: String, Codable {
    case point = "Point"
}
struct Properties: Codable {
    let name: String?
    let country: String?
    let countryCode: String?
    let state: String?
    let county: String?
    let city: String?
    let postcode: String?
    let street: String?
    let lon, lat: Double?
    let formatted, addressLine1, addressLine2: String?
    let categories, details: [String]?
    let distance: Int?
    let placeID, quarter, housenumber: String?

    enum CodingKeys: String, CodingKey {
        case name, country
        case countryCode = "country_code"
        case state, county, city, postcode, street, lon, lat, formatted
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case categories, details, distance
        case placeID = "place_id"
        case quarter, housenumber
    }
}
