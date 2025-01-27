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
    var userPosition: CLLocationCoordinate2D?
    
    init(_ control: MapGymsNearby) {
        self.control = control
    }
    
    //Location marker is an annotation, here we center it when map is oppened
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first{
            if let annotation = annotationView.annotation{
                if annotation is MKUserLocation{
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
}
 
struct MapGymsNearby: UIViewRepresentable {
    let gymsFound: [GymModel]
    
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
            updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = gymsFound.map(GymAnnotation.init)
        mapView.addAnnotations(annotations)
    }
}

struct MapGymsNearbyView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var nearbyGyms: [GymModel] = [GymModel]()
    
    private func gerNearbyGyms() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "GYM"
        request.region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response{
                let mapItems = response.mapItems
                nearbyGyms = mapItems.map{
                    GymModel(placeMaker: $0.placemark)
                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            MapGymsNearby(gymsFound: nearbyGyms).onAppear{
                self.gerNearbyGyms()
            }.onAppear{
                CLLocationManager().requestWhenInUseAuthorization()
            }
            
            Button("Search gyms!"){
                gerNearbyGyms()
            }.disabled(nearbyGyms.count > 1)
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 100)
            
        }
        .ignoresSafeArea()

    }
}

#Preview {
    MapGymsNearbyView()
}
