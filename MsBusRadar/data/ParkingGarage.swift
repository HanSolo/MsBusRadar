//
//  ParkingGarage.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 26.07.26.
//

import Foundation
import CoreLocation


public class ParkingGarage: Identifiable, Equatable {
    public let id          : String
    public let name        : String
    public let totalSpaces : Int
    public let freeSpaces  : Int
    public let state       : ParkingGarageState
    public let timestamp   : Date
    public let lastUpdate  : String
    public var coordinate  : CLLocationCoordinate2D
    
    let timeFormatter : DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    
    init(name: String, totalSpaces: Int, freeSpaces: Int, state: ParkingGarageState, timestamp: Date) {
        self.id          = name
        self.name        = name
        self.totalSpaces = totalSpaces
        self.freeSpaces  = freeSpaces
        self.state       = state
        self.timestamp   = timestamp
        self.coordinate  = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.lastUpdate  = self.timeFormatter.string(for: self.timestamp) ?? ""
    }
    
    
    public static func == (lhs: ParkingGarage, rhs: ParkingGarage) -> Bool {
        lhs.id == rhs.id
    }
}
