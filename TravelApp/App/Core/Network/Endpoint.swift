//
//  Endpoint.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

enum Endpoint {
    enum Travel:String{
        case hotel = "hotels"
        case restaurant = "restaurants"
        case attraction = "attractions"
    }
    enum Weather: String {
        case data = "/data"
        case APIVersion = "/2.5"
        case weather = "/weather"
        case metric = "metric"
    }
    enum Geoapify: String{
        case version = "/v2"
        case places = "/places"
        case airport = "airport"
        case trainStation = "public_transport.train"
        case shoppingMall = "commercial.shopping_mall"
        case superMarket = "commercial.supermarket"
        case hotel = "accommodation.hotel"
    }
}

