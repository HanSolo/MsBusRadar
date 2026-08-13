//
//  ChargingStation.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 12.08.26.
//

import Foundation
import CoreLocation


public class ChargingStation: Identifiable, Equatable {
    public let id          : String
    public let name        : String
    public let powerKw     : Double
    public let state       : String
    public let type        : String
    public let points      : Int
    public let connectors  : [Connector]
    public var coordinate  : CLLocationCoordinate2D
    
        
    init(id: String, name: String, powerKw: Double, state: String, type: String, points: Int, connectors: [Connector], coordinate: CLLocationCoordinate2D) {
        self.id         = id
        self.name       = name
        self.powerKw    = powerKw
        self.state      = state
        self.type       = type
        self.points     = points
        self.connectors = connectors
        self.coordinate = coordinate
    }
    
        
    public static func == (lhs: ChargingStation, rhs: ChargingStation) -> Bool {
        lhs.id == rhs.id
    }
}
