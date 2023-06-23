//
//  APIRequest.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import Foundation

protocol APIRequest: DataRequest {
    associatedtype Response
    var baseURL: String { get }
    var method: HTTPMethod { get }
}

extension APIRequest {
    var baseURL: String {
        ""
    }
    
    var url: String {
        ""
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
}

