//
//  HomeViewModel.swift
//  TravelApp
//
//  Created by Onur Duyar on 24.06.2023.
//

import Foundation

final class HomeViewModel{
    static let shared = HomeViewModel()
    let networkService = BaseNetworkService()
    weak var delegate: WeatherViewModelDelegate?
    
    var city: WeatherElement?{
        didSet{
            delegate?.weatherDataDidChange(self)
        }
    }
    
    func fetchWeatherData(lat: String, lon: String){
        networkService.request(WeatherRequest(lat: lat, lon: lon)) { result in
            switch result{
            case .success(let response):
                self.city = response
            case .failure(let error):
                print(error)
                self.delegate?.weatherDataFetchDidFail(self, withError: error)
            }
        }
    }
}
protocol WeatherViewModelDelegate: AnyObject{
    func weatherDataDidChange(_ viewModel: HomeViewModel)
    func weatherDataFetchDidFail(_ viewModel: HomeViewModel, withError error: Error)
}
