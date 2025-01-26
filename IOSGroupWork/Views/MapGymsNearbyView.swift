//
//  MapGymsNearby.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 26/1/25.
//
import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    var control: MapGymsNearby
    
    init(_ control: MapGymsNearby) {
        self.control = control
    }
    
    //func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //    return nil
    //}
}
 
struct MapGymsNearby: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator{
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
    }
}

struct MapGymsNearbyView: View {
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        MapGymsNearby()
    }
}

#Preview {
    MapGymsNearbyView()
}
