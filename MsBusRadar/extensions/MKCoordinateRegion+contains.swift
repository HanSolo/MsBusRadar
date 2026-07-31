//
//  MKCoordinateRegion+contains.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 31.07.26.
//

import Foundation
import MapKit


extension MKCoordinateRegion {
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let latDelta = span.latitudeDelta  / 2.0
        let lonDelta = span.longitudeDelta / 2.0

        let minLat = center.latitude  - latDelta
        let maxLat = center.latitude  + latDelta
        let minLon = center.longitude - lonDelta
        let maxLon = center.longitude + lonDelta

        return coordinate.latitude  >= minLat &&
               coordinate.latitude  <= maxLat &&
               coordinate.longitude >= minLon &&
               coordinate.longitude <= maxLon
    }
}
