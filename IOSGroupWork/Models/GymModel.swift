//
//  GymModel.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 27/1/25.
//

import Foundation
import MapKit

struct GymModel {
    let placeMaker: MKPlacemark
    
    var id:UUID {
        return UUID()
    }
    
    var gymName: String {
        placeMaker.name ?? "No Name"
    }
    
    var title:String {
        placeMaker.title ?? "No Title"
    }
    
    var coordinate: CLLocationCoordinate2D {
        placeMaker.coordinate
    }
}
