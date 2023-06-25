//
//  ViewController.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let homeViewModel = HomeViewModel.shared
    private lazy var locationManager: LocationManager = {
        let manager = LocationManager()
        manager.delegate = self
        return manager
    }()
    var currentCity: WeatherElement?{
        didSet{
            print(currentCity ?? "")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        locationManager.checkLocationPermission()
        homeViewModel.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
// MARK: - WeatherViewModelDelegate
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
// MARK: - LocationManagerDelegate
extension ViewController: LocationManagerDelegate{
    func didUpdateLocation(latitude: String, longitude: String) {
        homeViewModel.fetchWeatherData(lat: latitude, lon: longitude)
    }
}
