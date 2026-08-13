//
//  ParkAndRide.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 13.08.26.
//

import Foundation
import CoreLocation


public class ParkAndRide: Identifiable, Equatable {
    public let id         : String
    public let name       : String
    public let slots      : Int
    public let cost       : String
    public let openHours  : String
    public var coordinate : CLLocationCoordinate2D
    
        
    init(name: String, slots: Int, cost: String, openHours: String, coordinate: CLLocationCoordinate2D) {
        self.id         = UUID().uuidString
        self.name       = name
        self.slots      = slots
        self.cost       = cost
        self.openHours  = openHours
        self.coordinate = coordinate
    }
    
    
    public static func == (lhs: ParkAndRide, rhs: ParkAndRide) -> Bool {
        lhs.id == rhs.id
    }
}

