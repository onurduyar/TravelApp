//
//  DetailViewModel.swift
//  TravelApp
//
//  Created by Onur Duyar on 29.06.2023.
//

import Foundation

final class DetailViewModel<T: Decodable> {
    let networkService = BaseNetworkService()
    weak var delegate: DetailViewModelDelegate?
    
    var modelResponse: T? {
        didSet {
            delegate?.travelDataUpdated(self)
        }
    }
    
    func calculateLatAndLon(latitude: Double, longitude: Double) -> FourSideLocation {
        let bl_latitude = latitude - 0.35
        let bl_longitude = longitude - 0.35
        let tr_longitude = longitude + 0.35
        let tr_latitude = latitude + 0.35
        
        let location = FourSideLocation(bl_latitude: bl_latitude, bl_longtitude: bl_longitude, tr_longtitude: tr_longitude, tr_latitude: tr_latitude)
        
        return location
    }
    
    func fetchTravelAPI(type: String, latitude: String, longitude: String) {
        let location = self.calculateLatAndLon(latitude: Double(latitude)!, longitude: Double(longitude)!)
        let bl_latitude: String = String(location.bl_latitude)
        let bl_longitude: String = String(location.bl_longtitude)
        let tr_longitude: String = String(location.tr_longtitude)
        let tr_latitude: String = String(location.tr_latitude)
        
        let request = TravelRequest<T>(type: type, bl_latitude: bl_latitude, bl_longitude: bl_longitude, tr_longitude: tr_longitude, tr_latitude: tr_latitude)
        
        networkService.request(request) { result in
            switch result {
            case .success(let response):
                self.modelResponse = response
            case .failure(let error):
                print(error)
                self.delegate?.travelDataDidFail(self, withError: error)
            }
        }
    }
    func fetchGeoApify(endpoint: String, latitude: String, longitude: String){
        let request = PlaceRequest(endpoint: endpoint, lat: latitude, lon: longitude)
        networkService.request(request) { result in
            switch result {
            case .success(let response):
                self.modelResponse = response as? T
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.travelDataDidFail(self, withError: error)
            }
        }
    }
}
protocol DetailViewModelDelegate: AnyObject {
    func travelDataUpdated<T>(_ viewModel: DetailViewModel<T>)
    func travelDataDidFail<T>(_ viewModel: DetailViewModel<T>, withError error: Error)
}
