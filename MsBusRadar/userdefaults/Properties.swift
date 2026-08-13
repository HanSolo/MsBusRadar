//
//  Properties.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26
//

import Foundation
import SwiftUI
import MapKit


extension Key {
    static let showStops             : Key = "showStops"
    static let favoriteLines         : Key = "favoriteLines"
    static let showFavoriteLines     : Key = "showFavoriteLines"
    static let favoriteStops         : Key = "favoriteStops"
    static let showFavoriteStops     : Key = "showFavoriteStops"
    static let showParkAndRides      : Key = "showParkAndRides"
    static let showParkingGarages    : Key = "showParkingGarages"
    static let showConstructionSites : Key = "showConstructionSites"
    static let showFuelStations      : Key = "showFuelStations"
    static let showChargingStations  : Key = "showChargingStations"
    static let lastFuelPriceUpdate   : Key = "lastFuelPriceUpdate"
}



// Define storage
public struct Properties {
    
    static var instance = Properties()
    
    @UserDefault(key: .showStops, defaultValue: false)
    var showStops: Bool?
    
    @UserDefault(key: .favoriteLines, defaultValue: "")
    var favoriteLines: String?
    
    @UserDefault(key: .showFavoriteLines, defaultValue: false)
    var showFavoriteLines: Bool?
    
    @UserDefault(key: .favoriteStops, defaultValue: "")
    var favoriteStops: String?
    
    @UserDefault(key: .showFavoriteStops, defaultValue: false)
    var showFavoriteStops: Bool?
    
    @UserDefault(key: .showParkAndRides, defaultValue: false)
    var showParkAndRides: Bool?
    
    @UserDefault(key: .showParkingGarages, defaultValue: false)
    var showParkingGarages: Bool?
    
    @UserDefault(key: .showConstructionSites, defaultValue: false)
    var showConstructionSites: Bool?
        
    @UserDefault(key: .showFuelStations, defaultValue: false)
    var showFuelStations: Bool?
    
    @UserDefault(key: .showChargingStations, defaultValue: false)
    var showChargingStations: Bool?
    
    @UserDefault(key: .lastFuelPriceUpdate, defaultValue: Calendar.current.date(byAdding: .second, value: -65, to: Date.now)!)
    var lastFuelPriceUpdate: Date?
    
    private init() {}
}
