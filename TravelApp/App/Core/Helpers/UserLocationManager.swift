//
//  UserLocationManager.swift
//  TravelApp
//
//  Created by Onur Duyar on 25.06.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    let locationManager = CLLocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func checkLocationPermission() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        handleLocationAuthorizationStatus(authorizationStatus)
    }
    
    func handleLocationAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            startLocationUpdates()
        default:
            break
        }
    }
    
    func startLocationUpdates() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        print(latitude)
        print(longitude)
        delegate?.didUpdateLocation(latitude: String(latitude), longitude: String(longitude))
        stopLocationUpdates()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager,_ status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status)
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startLocationUpdates()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didfail(error: error)
    }
}

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(latitude: String, longitude: String)
    func didfail(error: Error)
}
