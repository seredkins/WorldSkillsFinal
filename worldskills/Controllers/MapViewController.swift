//
//  MapViewController.swift
//  WorldSkills
//
//  Created by ladmin on 15.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var address: String?
        
    var annotationView = MKAnnotationView()
    
    var annotation = MKPointAnnotation()
    
//    var pinView = MKPinAnnotationView()
    
    
    var userLocation: CLLocation?
    
    var destinationLocation: [Double]?
    
    
    var competitionTitle: String?
    
    var competitionImage: UIImage?
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        userLocation = location
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        mapView.showsUserLocation = true
        
        buildRoute(to: destinationLocation!)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView()
        view.annotation = annotation
        view.image = competitionImage
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = #colorLiteral(red: 0.3135240761, green: 0.6626431686, blue: 1, alpha: 1)
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func viewDidLoad() {
        locationManager.requestWhenInUseAuthorization()
        
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self

        locationManager.startUpdatingLocation()
        
        mapView.showsCompass = true
        mapView.showsBuildings = true
        
        annotationView.isEnabled = true
        
        
    }
    
    func buildRoute(to coordinate: [Double]) {
        let destinationMapItem = MKMapItem(from: coordinate)
        
        let sourceMapItem = MKMapItem(placemark: MKPlacemark(coordinate: userLocation!.coordinate))
        
        let destinationAnnotation = annotation
        destinationAnnotation.title = competitionTitle
        if let location = destinationMapItem.placemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        mapView.showAnnotations([destinationAnnotation], animated: true)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .any
        
        MKDirections(request: directionRequest).calculate
        { (response, error) in
            guard let response = response, error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            let route = response.routes[0]
            
            DispatchQueue.main.async {
                self.showOnMap(route: route)
            }
        }
        
    }
    
    func showOnMap(route: MKRoute) {
        
        if mapView.overlays.count > 0 {
            for overlay in mapView.overlays {
                mapView.remove(overlay)
            }
        }
        
        
        mapView.add(route.polyline, level: .aboveRoads)
        let rect = route.polyline.boundingMapRect
        mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setVC = segue.destination as? AddressSettingsViewController else {
            return
        }
        
        setVC.strForKolhozArr = address!
    }
 
    
    

}
