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
    var locationManager            : CLLocationManager?
    var mapRegion                  : MKCoordinateRegion?
    var networkMonitor             : NetworkMonitor         = NetworkMonitor()
    var busses                     : [Bus]                  = [] {
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
    var stops                      : [Stop]                 = []
    var favoriteLines              : [String]               = Properties.instance.favoriteLines!.components(separatedBy: ",") {
        didSet {
            Properties.instance.favoriteLines = self.favoriteLines.joined(separator: ",")
        }
    }
    var favoriteStops              : [String]               = Properties.instance.favoriteStops!.components(separatedBy: ",") {
        didSet {
            Properties.instance.favoriteStops = self.favoriteStops.joined(separator: ",")
        }
    }
    var selectedStops              : [Stop]                 = []
    var stopLines                  : [String: [String]]     = [:]
    var stopsOfSelectedLine        : [Stop]                 = []
    var parkingGarages             : [ParkingGarage]        = []
    var showStops                  : Bool                   = Properties.instance.showStops! {
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
    var showStopsBinding           : Binding<Bool> {
        Binding(get: { self.showStops}, set: { self.showStops = $0 })
    }
    var showFavoriteLines          : Bool                   = Properties.instance.showFavoriteLines! {
        didSet {
            Properties.instance.showFavoriteLines = self.showFavoriteLines
        }
    }
    var showFavoriteLinesBinding   : Binding<Bool> {
        Binding(get: { self.showFavoriteLines}, set: { self.showFavoriteLines = $0 })
    }
    var showFavoriteStops          : Bool                   = Properties.instance.showFavoriteStops! {
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
    var showFavoriteStopsBinding   : Binding<Bool> {
        Binding(get: { self.showFavoriteStops}, set: { self.showFavoriteStops = $0 })
    }
    var showBusInfo                : Bool                   = false
    var showStationData            : Bool                   = false
    var showStationDataBinding     : Binding<Bool> {
        Binding(get: { self.showStationData}, set: { self.showStationData = $0 })
    }
    var selectedStop               : Stop                   = Constants.DEFAULT_STOP
    var selectedBus                : Bus                    = Constants.DEFAULT_BUS {
        didSet {
            if self.selectedBus.id == "none" { return }            
            self.nextStop = self.stops.first(where: { $0.id.starts(with: self.selectedBus.nextStopId) }) ?? Constants.DEFAULT_STOP
        }
    }
    var selectedBusLastUpdate      : String                 = ""
    var selectedBusLocation        : CLLocationCoordinate2D = Constants.MAP_CENTER
    var selectedParkingGarage      : ParkingGarage          = Constants.DEFAULT_PARKING_GARAGE
    var selectedTrainstation       : String                 = ""
    var nextStop                   : Stop                   = Constants.DEFAULT_STOP
    var currentMapSpan             : MKCoordinateSpan       = Constants.MAP_SPAN
    
        
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
            manager.delegate = self
            self.locationManager = manager
            // Request authorization triggers callback where further handling occurs
            manager.requestWhenInUseAuthorization()
        }
    }
}

