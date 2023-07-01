//
//  PlaceDetailVC.swift
//  TravelApp
//
//  Created by Onur Duyar on 1.07.2023.
//

import UIKit
import MapKit

class PlaceDetailVC<T: Decodable>: UIViewController {
    let placeDetailView = PlaceDetailView()
    var placePhoto: String?{
        didSet{
            guard let placePhoto else {return}
            placeDetailView.imageView.image = UIImage(named: placePhoto)
        }
    }
    var index: Int?
    var selectedData: T? {
        didSet {
            if let hotelData = selectedData as? Hotel {
                print(hotelData)
                placeDetailView.addressTitle = hotelData.name ?? ""
                placeDetailView.address = ""
                placeDetailView.imageView.downloadImage(from: URL(string: hotelData.photo?.images?.large?.url ?? ""))
            } else if let restaurantData = selectedData as? Restaurant {
                print(restaurantData)
                placeDetailView.addressTitle = restaurantData.name ?? ""
                placeDetailView.address = restaurantData.address ?? ""
                placeDetailView.imageView.downloadImage(from: URL(string: restaurantData.photo?.images?.large?.url ?? ""))
            } else if let attractionData = selectedData as? Attraction {
                print(attractionData)
                placeDetailView.addressTitle = attractionData.name ?? ""
                placeDetailView.address = ""
                placeDetailView.imageView.downloadImage(from: URL(string: attractionData.photo?.images?.large?.url ?? ""))
            } else if let placeData = selectedData as? Feature {
                print(placeData)
                placeDetailView.addressTitle = placeData.properties?.name ?? ""
                placeDetailView.address = placeData.properties?.addressLine2 ?? ""
                
               
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = placeDetailView
        placeDetailView.delegate = self
    }
}


extension PlaceDetailVC: PlaceDetailVCDelegate{
    func showOnMapButtonTapped() {
        let mapVC = MapVC<T>()
        mapVC.index = index
        mapVC.selectedData = selectedData
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    
}
