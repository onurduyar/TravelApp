//
//  FourSideLocation.swift
//  TravelApp
//
//  Created by Onur Duyar on 29.06.2023.
//

import Foundation

class FourSideLocation{
    let bl_latitude: Double
    let bl_longtitude: Double
    let tr_longtitude: Double
    let tr_latitude: Double
    
    init(bl_latitude: Double, bl_longtitude: Double, tr_longtitude: Double, tr_latitude: Double) {
        self.bl_latitude = bl_latitude
        self.bl_longtitude = bl_longtitude
        self.tr_longtitude = tr_longtitude
        self.tr_latitude = tr_latitude
    }
}
