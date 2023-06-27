//
//  ViewController.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import UIKit
import CoreLocation
import SwiftUI

class ViewController: UIViewController {
    var cardView = CardView(selectedWeatherStore: SelectedWeatherStore() )
    let homeViewModel = HomeViewModel.shared
    private lazy var locationManager: LocationManager = {
        let manager = LocationManager()
        manager.delegate = self
        return manager
    }()
    var currentCity: WeatherElement?{
        didSet{
            cardView.selectedWeatherStore.selectedWeather = currentCity
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeView = HomeView(cardView: cardView)
        view = homeView
        locationManager.checkLocationPermission()
        homeViewModel.delegate = self
        homeView.delegate = self
        homeView.activityIndicator.startAnimating()
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
// MARK: - HomeViewDelegate
extension ViewController: HomeViewDelegate{
    func didSelectShoppingRectangle(withTag tag: Int) {
        switch tag {
        case 0:
            print("shopping mal")
            break
        case 1:
            print("supermarket")
            break
        default:
            break
        }
    }
    
    func didSelectTransportationRectangle(withTag tag: Int) {
        switch tag {
        case 0:
            print("airport")
            break
        case 1:
            print("trainstation")
            break
        default:
            break
        }
    }
    
    func didSelectCircle(withTag tag: Int) {
        switch tag {
        case 0:
            print("hostel")
            break
        case 1:
            print("restaurant")
            break
        case 2:
            print("attractions")
            break
        default:
            break
        }
    }
}
class ViewController2: UIViewController{
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}
