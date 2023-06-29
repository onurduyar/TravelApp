//
//  DetailVC.swift
//  TravelApp
//
//  Created by Onur Duyar on 27.06.2023.
//

import UIKit

final class DetailVC<T: Decodable>: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var typeOfPlace: String?
    var dataCount: Int?
    var selectedData: T?{
        didSet{
            if let hotels = selectedData as? HotelModel {
                dataCount =  hotels.data?.count
            } else if let restaurants = selectedData as? RestaurantModel {
                dataCount =  restaurants.data?.count
            } else if let attractions = selectedData as? AttractionModel {
                dataCount =  attractions.data?.count
            } else if let places = selectedData as? PlaceModel {
                dataCount =  places.features?.count
            } else {
                dataCount = .zero
            }
            detailView.refresh()
        }
    }
    let detailView = DetailView()
    let detailViewModel = DetailViewModel<T>()
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
        
        detailViewModel.delegate = self
        locationManager.delegate = self
        locationManager.checkLocationPermission()
        
    }
    
    
    // MARK: -  UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataCount ?? .zero
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        cell.detailText = "sasa\(indexPath.row)"
        cell.image = UIImage(named: "restaurant_icon")
        return cell
    }
}

extension DetailVC: LocationManagerDelegate{
    func didUpdateLocation(latitude: String, longitude: String) {
        switch T.self {
        case is HotelModel.Type:
            detailViewModel.fetchTravelAPI(type: "hotels", latitude: latitude, longitude: longitude)
            break
        case is RestaurantModel.Type:
            detailViewModel.fetchTravelAPI(type: "restaurants", latitude: latitude, longitude: longitude)
            break
        case is AttractionModel.Type:
            detailViewModel.fetchTravelAPI(type: "attractions", latitude: latitude, longitude: longitude)
            break
        case is PlaceModel.Type:
            guard let typeOfPlace else {return}
            detailViewModel.fetchGeoApify(endpoint: typeOfPlace, latitude: latitude, longitude: longitude)
            break
        default:
            break
        }
    }
}

extension DetailVC: DetailViewModelDelegate{
    func travelDataUpdated<T>(_ viewModel: DetailViewModel<T>) where T : Decodable {
        selectedData = detailViewModel.modelResponse
    }
    
    func travelDataDidFail<T>(_ viewModel: DetailViewModel<T>, withError error: Error) where T : Decodable {
        print(error.localizedDescription)
    }
    
    
}
