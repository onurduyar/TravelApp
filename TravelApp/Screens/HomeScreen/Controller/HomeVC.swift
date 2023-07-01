//
//  ViewController.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import UIKit
import CoreLocation
import SwiftUI

final class HomeVC: UIViewController {
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
extension HomeVC: WeatherViewModelDelegate {
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
extension HomeVC: LocationManagerDelegate{
    func didUpdateLocation(latitude: String, longitude: String) {
        homeViewModel.fetchWeatherData(lat: latitude, lon: longitude)
    }
}
// MARK: - HomeViewDelegate
extension HomeVC: HomeViewDelegate{
    func didSelectShoppingRectangle(withTag tag: Int) {
        switch tag {
        case 0:
            let destionationVC = DetailVC<PlaceModel>()
            destionationVC.typeOfPlace = Endpoint.Geoapify.shoppingMall.rawValue
            navigationController?.pushViewController(destionationVC, animated: true)
            break
        case 1:
            let destionationVC = DetailVC<PlaceModel>()
            destionationVC.typeOfPlace = Endpoint.Geoapify.superMarket.rawValue
            navigationController?.pushViewController(destionationVC, animated: true)
            break
        default:
            break
        }
    }
    
    func didSelectTransportationRectangle(withTag tag: Int) {
        switch tag {
        case 0:
            let destionationVC = DetailVC<PlaceModel>()
            destionationVC.typeOfPlace = Endpoint.Geoapify.airport.rawValue
            navigationController?.pushViewController(destionationVC, animated: true)
            break
        case 1:
            let destionationVC = DetailVC<PlaceModel>()
            destionationVC.typeOfPlace = Endpoint.Geoapify.trainStation.rawValue
            navigationController?.pushViewController(destionationVC, animated: true)
            break
        default:
            break
        }
    }
    
    func didSelectCircle(withTag tag: Int) {
        switch tag {
        case 0:
            let destionationVC = DetailVC<PlaceModel>()
            destionationVC.typeOfPlace = Endpoint.Geoapify.hotel.rawValue
            navigationController?.pushViewController(destionationVC, animated: true)
           // navigationController?.pushViewController(DetailVC<HotelModel>(), animated: true)
            break
        case 1:
            navigationController?.pushViewController(DetailVC<RestaurantModel>(), animated: true)
            break
        case 2:
            navigationController?.pushViewController(DetailVC<AttractionModel>(), animated: true)
            break
        default:
            break
        }
    }
}
