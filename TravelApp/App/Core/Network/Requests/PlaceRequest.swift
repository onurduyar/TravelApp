//
//  PlaceRequest.swift
//  TravelApp
//
//  Created by Onur Duyar on 23.06.2023.
//

import Foundation

struct PlaceRequest: APIRequest {
    let appID: String
    var lat,lon: String
    
    typealias Response = PlaceModel
    var baseURL: String{
        "https://api.geoapify.com"
    }
    var method: HTTPMethod {
        .get
    }
    var path: String{
        Endpoint.Geoapify.version.rawValue.appending(Endpoint.Geoapify.places.rawValue)
    }
    var queryItems: [String : String] {
        [
            "apiKey": appID,
            "limit": "20",
            "categories": "catering.restaurant",
            "bias": "proximity:\(lon),\(lat)"
        ]
    }
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
        guard let apiKey = ProcessInfo.processInfo.environment["geoapifyAPI_KEY"] else {
            fatalError(ErrorResponse.apiKeyMissing.rawValue)
        }
        self.appID = apiKey
    }
    func decode(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
