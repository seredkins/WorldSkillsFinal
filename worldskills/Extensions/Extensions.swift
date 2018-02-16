//
//  Extensions.swift
//  WorldSkills
//
//  Created by ladmin on 15.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import Foundation
import MapKit

extension MKMapItem {
     convenience init (from coordinates: [Double]) {
        
        let coordinates = CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
        
        let placemark = MKPlacemark(coordinate: coordinates)
        
        self.init(placemark: placemark)
        
    }
}
