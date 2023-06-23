//
//  WeatherRequest.swift
//  TravelApp
//
//  Created by Onur Duyar on 23.06.2023.
//

import Foundation
struct WeatherRequest: APIRequest {
    let appID: String
    var lat,lon: String
    
    typealias Response = WeatherElement
    var baseURL: String{
        "https://api.openweathermap.org"
    }
    var method: HTTPMethod {
        .get
    }
    var path: String{
        Endpoint.Weather.data.rawValue.appending(Endpoint.Weather.APIVersion.rawValue).appending(Endpoint.Weather.weather.rawValue)
    }
    var queryItems: [String : String] {
        [
            "appid": appID,
            "lat": lat,
            "lon": lon,
        ]
    }
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
        guard let apiKey = ProcessInfo.processInfo.environment["weatherAPI_KEY"] else {
            fatalError(ErrorResponse.apiKeyMissing.rawValue)
        }
        self.appID = apiKey
    }
    func decode(_ data: Data) throws -> WeatherElement {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
