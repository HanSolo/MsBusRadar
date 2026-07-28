//
//  ConstructionSite.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 28.07.26.
//

import Foundation
import SwiftUI
import CoreLocation


public struct ConstructionSite : Identifiable, Hashable, Equatable {
    private(set) public var id  : String
    let name   : String
    let type   : String
    let start  : Date
    let end    : Date
    let color  : Color // depends on typ_id: 1 = Vollsperring, 2 = Teilsperrung
    let coords : [[CLLocationCoordinate2D]]
    
    
    init(name: String, type: String, start: Date, end: Date, color: Color, coords: [[CLLocationCoordinate2D]]) {
        self.id     = UUID().uuidString
        self.name   = name
        self.type   = type
        self.start  = start
        self.end    = end
        self.color  = color
        self.coords = coords
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(start)
        hasher.combine(end)
    }
    
    public static func == (lhs: ConstructionSite, rhs: ConstructionSite) -> Bool {
        return lhs.id == rhs.id
    }    
}
