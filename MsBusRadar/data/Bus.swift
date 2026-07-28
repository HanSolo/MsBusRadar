//
//  Bus.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26.
//

import Foundation
import MapKit


public struct Bus : Identifiable, Equatable {
    private(set) public var id  : String
    var line          : String
    var timestamp     : Int
    var currentStopId : String
    var nextStopId    : String
    var direction     : String
    var delay         : Int
    var directionId   : String
    var coordinate    : CLLocationCoordinate2D
    var lastUpdate    : String
    
    let timeFormatter : DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    
    init(busId: String, line: String, timestamp: Int, currentStopId: String, nextStopId: String, direction: String, delay: Int, directionId: String, coordinate: CLLocationCoordinate2D) {
        self.id            = busId
        self.line          = line
        self.timestamp     = timestamp
        self.currentStopId = currentStopId
        self.nextStopId    = nextStopId
        self.direction     = direction
        self.delay         = delay
        self.directionId   = directionId
        self.coordinate    = coordinate
        self.lastUpdate    = self.timeFormatter.string(for: Date.init(timeIntervalSince1970: TimeInterval(timestamp))) ?? ""
    }
    
    
    public static func == (lhs: Bus, rhs: Bus) -> Bool {
        lhs.id == rhs.id
    }
}
