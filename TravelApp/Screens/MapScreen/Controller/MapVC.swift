//
//  MapVC.swift
//  TravelApp
//
//  Created by Onur Duyar on 1.07.2023.
//

import UIKit
import MapKit

class MapVC<T: Decodable>: UIViewController {
    let mapView = MapView()
    var index: Int?
    var selectedData: T? {
        didSet {
            if let hotelData = selectedData as? Hotel {
                print(hotelData)
                if let lat = hotelData.latitude, let lon = hotelData.longitude {
                    let coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(lon) ?? 0.0)
                    mapView.showAnnotation(coordinate: coordinate)
                    mapView.itemName = hotelData.name
                }
            } else if let restaurantData = selectedData as? Restaurant {
                print(restaurantData)
                if let lat = restaurantData.latitude, let lon = restaurantData.longitude {
                    let coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(lon) ?? 0.0)
                    mapView.showAnnotation(coordinate: coordinate)
                    mapView.itemName = restaurantData.name
                }
            } else if let attractionData = selectedData as? Attraction {
                print(attractionData)
                if let lat = attractionData.latitude, let lon = attractionData.longitude {
                    let coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(lon) ?? 0.0)
                    mapView.showAnnotation(coordinate: coordinate)
                    mapView.itemName = attractionData.name
                }
            } else if let placeData = selectedData as? Feature {
                print(placeData)
                if let lat = placeData.geometry?.coordinates?.last, let lon = placeData.geometry?.coordinates?.first {
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    mapView.showAnnotation(coordinate: coordinate)
                    mapView.itemName = placeData.properties?.name
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mapView
        
    }
}
