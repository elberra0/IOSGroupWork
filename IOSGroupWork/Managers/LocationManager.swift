//
//  LocationManager.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 26/1/25.
//

import MapKit
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        //self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("Status: \(status)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else { return }
        
        self.location = locations.last
    }
    
}
