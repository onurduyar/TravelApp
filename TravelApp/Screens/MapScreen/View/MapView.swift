//
//  MapView.swift
//  TravelApp
//
//  Created by Onur Duyar on 1.07.2023.
//

import UIKit
import MapKit

class MapView: UIView {
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    var itemName: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupConstraints()
        mapView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(mapView)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.layoutMarginsGuide.snp.top)
        }
    }
    
    func showAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        mapView.setCenter(coordinate, animated: true)
        
    }
    func openMapsWithCoordinate(coordinate: CLLocationCoordinate2D) {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let requestLocation = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
            if let placemark = placemarks {
                if placemark.count > 0 {
                    let newPlacemark = MKPlacemark(placemark: placemark[0])
                    let item = MKMapItem(placemark: newPlacemark)
                    item.name = self.itemName
                    let launchOption = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
                    item.openInMaps(launchOptions: launchOption)
                }
            }
        }
    }
}

extension MapView: MKMapViewDelegate{
  
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let reuseIdentifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.pinTintColor = .blue
        } else {
            annotationView?.annotation = annotation
            annotationView?.pinTintColor = .blue
        }
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            openMapsWithCoordinate(coordinate: annotation.coordinate)
        }
    }
}
