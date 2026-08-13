//
//  FillingStation.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 12.08.26.
//

import Foundation
import CoreLocation


public class FuelStation: Identifiable, Equatable {
    public let id          : String
    public let brand       : String
    public let e5          : Double
    public let e10         : Double
    public let diesel      : Double
    public let isOpen      : Bool
    public var coordinate  : CLLocationCoordinate2D
    
        
    init(id: String, brand: String, e5: Double = 0.0, e10: Double = 0.0, diesel: Double = 0.0, isOpen: Bool = false, coordinate: CLLocationCoordinate2D) {
        self.id         = id
        self.brand      = brand
        self.e5         = e5
        self.e10        = e10
        self.diesel     = diesel
        self.isOpen     = isOpen
        self.coordinate = coordinate
    }
    
    
    public static func == (lhs: FuelStation, rhs: FuelStation) -> Bool {
        lhs.id == rhs.id
    }
}
