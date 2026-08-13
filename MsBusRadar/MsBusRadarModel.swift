//
//  MsBusRadarModel.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26
//

import Foundation
import SwiftUI
import SwiftData
import MapKit


@MainActor @Observable
public class MsBusRadarModel : NSObject, CLLocationManagerDelegate {
    var locationManager              : CLLocationManager?
    var mapRegion                    : MKCoordinateRegion?
    var networkMonitor               : NetworkMonitor         = NetworkMonitor()
    var busses                       : [Bus]                  = [] {
        didSet {
            if self.selectedBus.id == "none" { return }
            if let bus = self.busses.filter({ $0.id == self.selectedBus.id }).first {
                self.selectedBusLastUpdate = bus.lastUpdate
                self.selectedBusLocation   = bus.coordinate
            } else {
                self.selectedBusLastUpdate = ""
                self.selectedBusLocation   = Constants.MAP_CENTER
            }
        }
    }
    var stops                        : [Stop]                 = []
    var favoriteLines                : [String]               = Properties.instance.favoriteLines!.components(separatedBy: ",") {
        didSet {
            Properties.instance.favoriteLines = self.favoriteLines.joined(separator: ",")
        }
    }
    var favoriteStops                : [String]               = Properties.instance.favoriteStops!.components(separatedBy: ",") {
        didSet {
            Properties.instance.favoriteStops = self.favoriteStops.joined(separator: ",")
        }
    }
    var selectedStops                : [Stop]                 = []
    var stopLines                    : [String: [String]]     = [:]
    var stopsOfSelectedLine          : [Stop]                 = []
    var parkingGarages               : [ParkingGarage]        = []
    var constructionSites            : [ConstructionSite]     = [] {
        didSet {
            self.polylineItems.removeAll()
            self.polylineItems += self.constructionSites.flatMap { site in
                site.coords.map {
                    PolylineItem(name: site.name, type: site.type, start: site.start, end: site.end, coords: $0, color: site.color)
                }
            }
        }
    }
    var polylineItems                : [PolylineItem]         = []
    var fuelStations                 : [FuelStation]          = []
    var chargingStations             : [ChargingStation]      = []
    var showStops                    : Bool                   = Properties.instance.showStops! {
        didSet {
            Properties.instance.showStops = self.showStops
            if self.showStops {
                self.selectedStops.removeAll()
                if self.showFavoriteStops && !self.favoriteStops.isEmpty {
                    self.stops.forEach { stop in
                        if self.favoriteStops.contains(stop.globalId) {
                            self.selectedStops.append(stop)
                        }
                    }
                } else {
                    self.selectedStops += self.stops
                }
            } else {
                self.selectedStops.removeAll()
            }
        }
    }
    var showFavoriteLines            : Bool                   = Properties.instance.showFavoriteLines! {
        didSet {
            Properties.instance.showFavoriteLines = self.showFavoriteLines
        }
    }
    var showFavoriteStops            : Bool                   = Properties.instance.showFavoriteStops! {
        didSet {
            Properties.instance.showFavoriteStops = self.showFavoriteStops
            self.selectedStops.removeAll()
            if self.showFavoriteStops {                
                if self.favoriteStops.isEmpty {
                    self.selectedStops += self.stops
                } else {
                    self.stops.forEach { stop in
                        if self.favoriteStops.contains(stop.globalId) {
                            self.selectedStops.append(stop)
                        }
                    }
                }
            } else {
                self.selectedStops += self.stops
            }
        }
    }    
    var showBusInfo                  : Bool                   = false
    var showStationData              : Bool                   = false
    var showStationDataBinding       : Binding<Bool> {
        Binding(get: { self.showStationData}, set: { self.showStationData = $0 })
    }
    var showEvStation                : Bool                   = false
    var showEvStationBinding         : Binding<Bool> {
        .init(get: { self.showEvStation }, set: { self.showEvStation = $0 })
    }
    var showParkAndRides             : Bool                   = Properties.instance.showParkAndRides! {
        didSet {
            Properties.instance.showParkAndRides = self.showParkAndRides
            if !showParkAndRides { self.selectedParkAndRide = Constants.DEFAULT_PARK_AND_RIDE }
        }
    }
    var showParkingGarages           : Bool                   = Properties.instance.showParkingGarages! {
        didSet {
            Properties.instance.showParkingGarages = self.showParkingGarages
            if !showParkingGarages { self.selectedParkingGarage = Constants.DEFAULT_PARKING_GARAGE }
        }
    }
    var showConstructionSites        : Bool                   = Properties.instance.showConstructionSites! {
        didSet {
            Properties.instance.showConstructionSites = self.showConstructionSites
            if !showConstructionSites { self.selectedConstructionItem = Constants.DEFAULT_CONSTRUCTION_ITEM }
        }
    }
    var showFuelStations             : Bool                   = Properties.instance.showFuelStations! {
        didSet {
            Properties.instance.showFuelStations = self.showFuelStations
            if self.showFuelStations {
                if self.networkMonitor.isConnected {
                    let lastUpdate: Date = Properties.instance.lastFuelPriceUpdate!
                    if Date.now.timeIntervalSince(lastUpdate) > 120 {
                        Task {
                            self.fuelStations.removeAll()
                            self.fuelStations += await RestController.getFuelPrices()
                            Properties.instance.lastFuelPriceUpdate = Date.now
                        }
                    }
                }
            } else {
                self.selectedFuelStation = Constants.DEFAULT_FUEL_STATION
            }
        }
    }
    var showChargingStations         : Bool                   = Properties.instance.showChargingStations! {
        didSet {
            Properties.instance.showChargingStations = self.showChargingStations
            if !self.showChargingStations { self.selectedChargingStation = Constants.DEFAULT_CHARGING_STATION }
        }
    }
    var selectedStop                 : Stop                   = Constants.DEFAULT_STOP
    var selectedBus                  : Bus                    = Constants.DEFAULT_BUS {
        didSet {
            if self.selectedBus.id == "none" { return }            
            self.nextStop = self.stops.first(where: { $0.id.starts(with: self.selectedBus.nextStopId) }) ?? Constants.DEFAULT_STOP
        }
    }
    var selectedBusLastUpdate        : String                 = ""
    var selectedBusLocation          : CLLocationCoordinate2D = Constants.MAP_CENTER
    var selectedParkAndRide          : ParkAndRide            = Constants.DEFAULT_PARK_AND_RIDE
    var selectedParkingGarage        : ParkingGarage          = Constants.DEFAULT_PARKING_GARAGE
    var selectedTrainstation         : String                 = ""
    var selectedConstructionItem     : PolylineItem           = Constants.DEFAULT_CONSTRUCTION_ITEM
    var selectedFuelStation          : FuelStation            = Constants.DEFAULT_FUEL_STATION
    var selectedChargingStation      : ChargingStation        = Constants.DEFAULT_CHARGING_STATION
    var nextStop                     : Stop                   = Constants.DEFAULT_STOP
    var currentMapSpan               : MKCoordinateSpan       = Constants.MAP_SPAN
    
        
    public func deselectAll() -> Void {
        self.selectedStop             = Constants.DEFAULT_STOP
        self.selectedBus              = Constants.DEFAULT_BUS
        self.selectedParkAndRide      = Constants.DEFAULT_PARK_AND_RIDE
        self.selectedParkingGarage    = Constants.DEFAULT_PARKING_GARAGE
        self.selectedConstructionItem = Constants.DEFAULT_CONSTRUCTION_ITEM
        self.selectedFuelStation      = Constants.DEFAULT_FUEL_STATION
        self.selectedChargingStation  = Constants.DEFAULT_CHARGING_STATION
        self.stopsOfSelectedLine.removeAll()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Handle authorization and update location-related state here, called on main thread.
        // Handle changes in location authorization
        let previousAuthorizationStatus = manager.authorizationStatus
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus != previousAuthorizationStatus {
            checkLocationAuthorization()
        }
    }
    
    public func getUserLocation() -> CLLocationCoordinate2D? {
        return self.locationManager?.location?.coordinate
    }
    
    private func checkLocationAuthorization() {
        // Check location authorization status
        guard let location = self.locationManager else {
            return
        }
        switch location.authorizationStatus {
        case .notDetermined:
            debugPrint("Location authorization is not determined.")
        case .restricted:
            debugPrint("Location is restricted.")
        case .denied:
            debugPrint("Location permission denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            // Update map region with user's location
            if let location = location.location {
                self.mapRegion = MKCoordinateRegion(center: location.coordinate,span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }
        default:
            break
        }
    }
    
    func checkIfLocationIsEnabled() {
        if locationManager == nil {
            let manager : CLLocationManager = CLLocationManager()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.delegate        = self
            self.locationManager    = manager
            // Request authorization triggers callback where further handling occurs
            manager.requestWhenInUseAuthorization()
        }
    }
}
