//
//  HotelRequest.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import Foundation

struct TravelRequest<T: Decodable>: APIRequest {
    typealias Response = T

    var type: String
    var bl_latitude: String
    var bl_longitude: String
    var tr_longitude: String
    var tr_latitude: String
    
    var baseURL: String{
        "https://travel-advisor.p.rapidapi.com"
    }
    var headers: [String : String] {
        guard let travelAPI_KEY = ProcessInfo.processInfo.environment["travelAPI_KEY"] else {
            fatalError(ErrorResponse.apiKeyMissing.rawValue)
        }
       return ["X-RapidAPI-Key": travelAPI_KEY]
    }
    var method: HTTPMethod {
        .get
    }
    
    var url: String {
        "/\(type)/list-in-boundary"
    }
    
    var queryItems: [String: String] {
        [
            "bl_latitude": bl_latitude,
            "bl_longitude": bl_longitude,
            "tr_longitude": tr_longitude,
            "tr_latitude": tr_latitude
        ]
    }
    
    func decode(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
