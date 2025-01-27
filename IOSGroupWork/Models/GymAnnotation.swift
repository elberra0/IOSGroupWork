//
//  GymAnnotation.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 27/1/25.
//

import Foundation
import MapKit
import UIKit

final class GymAnnotation: NSObject, MKAnnotation {
    let title:String?
    var coordinate: CLLocationCoordinate2D
    
    init(gym: GymModel) {
        title = gym.title
        coordinate = gym.coordinate
    }
}
