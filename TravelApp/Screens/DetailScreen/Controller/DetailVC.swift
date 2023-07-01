//
//  DetailVC.swift
//  TravelApp
//
//  Created by Onur Duyar on 27.06.2023.
//

import UIKit

final class DetailVC<T: Decodable>: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var typeOfPlace: String?
    var dataCount: Int?
    var selectedData: T?{
        didSet{
            if let hotels = selectedData as? HotelModel {
                dataCount =  hotels.data?.count
                DispatchQueue.main.async {
                    self.title = "Hotels"
                }
            } else if let restaurants = selectedData as? RestaurantModel {
                dataCount =  restaurants.data?.count
                DispatchQueue.main.async {
                    self.title = "Restaurants"
                }
            } else if let attractions = selectedData as? AttractionModel {
                dataCount =  attractions.data?.count
                DispatchQueue.main.async {
                    self.title = "Attractions"
                }
            } else if let places = selectedData as? PlaceModel {
                dataCount =  places.features?.count
                switch typeOfPlace {
                case Endpoint.Geoapify.airport.rawValue:
                    DispatchQueue.main.async {
                        self.title = "Airports"
                    }
                    break
                case Endpoint.Geoapify.trainStation.rawValue:
                    DispatchQueue.main.async {
                        self.title = "Train Stations"
                    }
                    break
                case Endpoint.Geoapify.shoppingMall.rawValue:
                    DispatchQueue.main.async {
                        self.title = "ShoppingMalls"
                    }
                    break
                case Endpoint.Geoapify.superMarket.rawValue:
                    DispatchQueue.main.async {
                        self.title = "Supermarkets"
                    }
                    break
                default:
                    break
                }
                
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
        
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
    }
    
    
    // MARK: -  UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let hotels = selectedData as? HotelModel {
            let hotel = hotels.data?[indexPath.row]
            let hotelData: Hotel? =  hotel
            let placeDetailVC = PlaceDetailVC<Hotel>()
            placeDetailVC.selectedData = hotelData
            navigationController?.pushViewController(placeDetailVC, animated: true)
        } else if let restaurants = selectedData as? RestaurantModel {
            let restaurant = restaurants.data?[indexPath.row]
            let restaurantData: Restaurant? =  restaurant
            let placeDetailVC = PlaceDetailVC<Restaurant>()
            placeDetailVC.selectedData = restaurantData
            navigationController?.pushViewController(placeDetailVC, animated: true)
        } else if let attractions = selectedData as? AttractionModel {
            let attraction = attractions.data?[indexPath.row]
            let attractionData: Attraction? =  attraction
            let placeDetailVC = PlaceDetailVC<Attraction>()
            placeDetailVC.selectedData = attractionData
            navigationController?.pushViewController(placeDetailVC, animated: true)
        } else if let places = selectedData as? PlaceModel {
            let feature = places.features?[indexPath.row]
            let placeDetailVC = PlaceDetailVC<Feature>()
            placeDetailVC.selectedData = feature
            switch typeOfPlace {
            case Endpoint.Geoapify.airport.rawValue:
                placeDetailVC.placePhoto = "airport_icon"
                break
            case Endpoint.Geoapify.trainStation.rawValue:
                placeDetailVC.placePhoto = "trainstation_icon"
                break
            case Endpoint.Geoapify.shoppingMall.rawValue:
                placeDetailVC.placePhoto = "shoppingmall_icon"
                break
            case Endpoint.Geoapify.superMarket.rawValue:
                placeDetailVC.placePhoto = "supermarket_icon"
                break
            case Endpoint.Geoapify.hotel.rawValue:
                placeDetailVC.placePhoto = "hostel_icon"
                break

            default:
                break
            }
            navigationController?.pushViewController(placeDetailVC, animated: true)
        }
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataCount ?? .zero
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        if let hotels = selectedData as? HotelModel {
            let hotel = hotels.data?[indexPath.row]
            cell.detailText = hotel?.name ?? "No information."
            guard let imageURL = URL(string: hotel?.photo?.images?.small?.url ?? "") else {return cell}
            cell.imageView?.downloadImage(from: imageURL)
            
        } else if let restaurants = selectedData as? RestaurantModel {
            let restaurant = restaurants.data?[indexPath.row]
            cell.detailText = restaurant?.name ?? "No information."
            guard let imageURL = URL(string: restaurant?.photo?.images?.small?.url ?? "") else {return cell}
            cell.imageView?.downloadImage(from: imageURL)
            
        } else if let attractions = selectedData as? AttractionModel {
            let attraction = attractions.data?[indexPath.row]
            cell.detailText = attraction?.name ?? "No information."
            guard let imageURL = URL(string: attraction?.photo?.images?.small?.url ?? "") else {return cell}
            cell.imageView?.downloadImage(from: imageURL)
            
        } else if let places = selectedData as? PlaceModel {
            let feature = places.features?[indexPath.row]
            cell.detailText = feature?.properties?.name ?? "No information."
        
            switch typeOfPlace {
            case Endpoint.Geoapify.airport.rawValue:
                DispatchQueue.main.async {
                    cell.image = UIImage(named: "airport_icon")
                }
                break
            case Endpoint.Geoapify.trainStation.rawValue:
                DispatchQueue.main.async {
                    cell.image = UIImage(named: "trainstation_icon")
                }
                break
            case Endpoint.Geoapify.shoppingMall.rawValue:
                DispatchQueue.main.async {
                    cell.image = UIImage(named: "shoppingmall_icon")
                }
                break
            case Endpoint.Geoapify.superMarket.rawValue:
                DispatchQueue.main.async {
                    cell.image = UIImage(named: "supermarket_icon")
                }
                break
            case Endpoint.Geoapify.hotel.rawValue:
                DispatchQueue.main.async {
                    cell.image = UIImage(named: "hostel_icon")
                }
                break
            default:
                break
            }
        } else {
            cell.detailText = "---"
            cell.image = nil
        }
        
        return cell
    }
}

extension DetailVC: LocationManagerDelegate{
    func didUpdateLocation(latitude: String, longitude: String) {
        switch T.self {
        case is HotelModel.Type:
            //detailViewModel.fetchTravelAPI(type: "hotels", latitude: latitude, longitude: longitude)
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
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    func travelDataDidFail<T>(_ viewModel: DetailViewModel<T>, withError error: Error) where T : Decodable {
        print(error.localizedDescription)
    }
    
    
}
