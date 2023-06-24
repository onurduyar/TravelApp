//
//  ViewController.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import UIKit

class ViewController: UIViewController {
    let homeViewModel = HomeViewModel.shared
    var currentCity: WeatherElement?{
        didSet{
            print(currentCity)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        homeViewModel.delegate = self
        HomeViewModel.shared.fetchWeatherData(lat: "38.7205", lon: "35.4826")
    }
}
extension ViewController: WeatherViewModelDelegate {
    func weatherDataDidChange(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.currentCity = viewModel.city
        }
    }
    
    func weatherDataFetchDidFail(_ viewModel: HomeViewModel, withError error: Error) {
        DispatchQueue.main.async {
            fatalError(error.localizedDescription)
        }
    }
    
  
}
