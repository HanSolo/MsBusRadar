//
//  Stop.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26.
//

import Foundation
import MapKit


public class Stop : Identifiable {
    private(set) public var id  : String
    var globalId    : String
    var name        : String
    var nr          : String
    var direction   : String
    var coordinate  : CLLocationCoordinate2D
    var lines       : [String]
    
    
    init(globalId: String, name: String, nr: String, direction: String, coordinate: CLLocationCoordinate2D) {
        self.id         = nr
        self.globalId   = globalId
        self.name       = name
        self.nr         = nr
        self.direction  = direction
        self.coordinate = coordinate
        self.lines      = []
    }
}
