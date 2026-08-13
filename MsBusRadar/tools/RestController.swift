//
//  RestController.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 08.05.26.
//

import Foundation
import Network
import SwiftUI
import CoreLocation


class RestController {
    private static let session : URLSession = URLSession.shared
    
    public static func isConnected() async -> Bool {
        let sessionConfig : URLSessionConfiguration = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest  = 2.0
        sessionConfig.timeoutIntervalForResource = 2.0
        
        let urlString : String      = "https://apple.com"
        let session   : URLSession  = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: .main)
        let finalUrl  : URL         = URL(string: urlString)!
        var request   : URLRequest  = URLRequest(url: finalUrl)
        request.httpMethod = "HEAD"
        do {
            let resp : (Data,URLResponse) = try await session.data(for: request)
            
            if let httpResponse = resp.1 as? HTTPURLResponse {
                return httpResponse.statusCode == 200
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    public static func getBusses() async -> [Bus] {
        let url    : URL   = URL(string: Constants.BUS_API_URL)!
        var busses : [Bus] = []
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return busses }
            let featureCollection = try JSONDecoder().decode(BusFeatureCollection.self, from: data)
            featureCollection.features?.forEach { feature in
                let coordinates : [Double] = feature.geometry!.coordinates ?? [0, 0]
                let bus : Bus = Bus(busId: feature.properties!.fahrzeugid ?? "-1", line: feature.properties!.linientext ?? "", timestamp: feature.properties!.visfahrplanlagezst ?? 0, currentStopId: feature.properties!.akthst ?? "", nextStopId: feature.properties!.nachhst ?? "", direction: feature.properties!.richtungstext ?? "", delay: feature.properties!.delay ?? 0, directionId: feature.properties!.richtungsid ?? "", coordinate: CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0]))
                busses.append(bus)
            }
            return busses
        } catch {
            return busses
        }
    }
    
    public static func getStops() async -> [Stop] {
        let url   : URL    = URL(string: Constants.STOP_API_URL)!
        var stops : [Stop] = []
        do {            
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return stops }
            let featureCollection = try JSONDecoder().decode(StopFeatureCollection.self, from: data)
            featureCollection.features?.forEach { feature in
                let coordinates : [Double]    = feature.geometry!.coordinates ?? [0, 0]
                let direction   : String      = feature.properties!.richtung ?? "" == "einwärts" ? "Stadteinwärts" : "Stadtauswärts"
                let nr          : String      = feature.properties?.nr ?? ""
                let globalId    : String      = feature.properties?.globalId ?? ""            
                let stop        : Stop = Stop(globalId: globalId, name: feature.properties!.lbez ?? "", nr: nr, direction: direction, coordinate: CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0]))
                stops.append(stop)
                
            }
            return stops
        } catch {
            return stops
        }
    }
    
    public static func getStopInfo(stopId: String, seconds: Int = 1200) async -> [StopInfo] {
        let url: URL = URL(string: "\(Constants.STOP_API_URL)/\(stopId)/abfahrten?sekunden=\(seconds)")!
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return [] }
            let stopInfoArray : [StopInfo] = try JSONDecoder().decode([StopInfo].self, from: data)
            return stopInfoArray
        } catch {
            return []
        }
    }
    
    public static func getGarageGarages() async -> [ParkingGarage] {
        let url            : URL             = URL(string: Constants.PLS_URL)!
        var parkingGarages : [ParkingGarage] = []
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return parkingGarages }
            let parser : ParkingGarageXMLParser = ParkingGarageXMLParser()
            let result : [ParkingGarage]        = try parser.parse(data: data)
            result.forEach { parkingGarages.append($0) }
            return parkingGarages
        } catch {
            return parkingGarages
        }
    }
    
    public static func getStationInfo(stationUrl: String) async -> Station? {
        let url     : URL        = URL(string: stationUrl)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
                
        var station : Station?
        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return station }
            station = try JSONDecoder().decode(Station.self, from: data)
            return station
        } catch {
            return station
        }
    }
 
    public static func getFuelPrices() async -> [FuelStation] {
        let url          : URL           = URL(string: "\(Constants.FUEL_STATIONS_URL)")!
        var fuelStations : [FuelStation] = []
        
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return [] }
            let fuelPrices : FuelPrices = try JSONDecoder().decode(FuelPrices.self, from: data)
            if fuelPrices.stations != nil {
                fuelPrices.stations?.forEach { station in
                    fuelStations.append(FuelStation(id: station.id ?? UUID().uuidString, brand: station.brand ?? "Unknown", e5: station.e5 ?? 0.0, e10: station.e10 ?? 0.0, diesel: station.diesel ?? 0.0, isOpen: station.isOpen ?? false , coordinate: CLLocationCoordinate2D(latitude: station.lat ?? 0.0, longitude: station.lng ?? 0.0)))
                }
            }
        } catch {
            return fuelStations
        }
        return fuelStations
    }
    
    public static func getChargingStations() async -> [ChargingStation] {
        let url: URL = URL(string: "\(Constants.CHARGING_STATIONS_URL)")!
        var chargingStations : [ChargingStation] = []
        
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return [] }
            let evstations : EChargingStations = try JSONDecoder().decode(EChargingStations.self, from: data)
            if evstations.data != nil {
                evstations.data?.payload?.stations?.forEach { station in
                    chargingStations.append(ChargingStation(id: station.stationId!, name: station.oprtr ?? "Unknown", powerKw: station.powerKw ?? 0.0, state: station.status ?? "", type: station.chargingType ?? "", points: station.points ?? 0, connectors: station.connectors ?? [], coordinate: CLLocationCoordinate2D(latitude: station.lat ?? 0.0, longitude: station.lon ?? 0.0)))
                }
            }
        } catch {
            return chargingStations
        }
        return chargingStations
    }
    
    public static func getConstructionSites() async -> [ConstructionSite] {
        let url: URL = URL(string: "\(Constants.CONSTRUCTION_SITE_URL)")!
        var constructionSites : [ConstructionSite] = []
                        
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { return [] }
            let sites : ConstructionSites = try JSONDecoder().decode(ConstructionSites.self, from: data)
            if sites.features != nil {
                sites.features!.forEach { feature in
                    let name   : String       = feature.properties!.bezeichnung ?? ""
                    let start  : Date         = Constants.CONSTRUCTION_SITE_DTF.date(from: feature.properties!.beginntam ?? "") ?? Date()
                    let end    : Date         = Constants.CONSTRUCTION_SITE_DTF.date(from: feature.properties!.endetam   ?? "") ?? Date()
                    let color  : Color        = feature.properties!.typId == 1 ? .red : .blue
                    let type   : String
                    if feature.properties!.typId == 1 {
                        type = "Vollsperrung"
                    } else if feature.properties!.typId == 2 {
                        type = "Teilsperrung"
                    } else {
                        type = ""
                    }
                    var coords : [[CLLocationCoordinate2D]] = []
                    switch feature.geometry!.type! {
                        case "LineString"      :
                            var coordinates: [CLLocationCoordinate2D] = []
                            feature.geometry?.line?.forEach { coords in
                                coordinates.append(CLLocationCoordinate2D(latitude: coords.last!, longitude: coords.first!))
                            }
                            coords.append(coordinates)
                        case "MultiLineString" :
                            feature.geometry?.multiLine?.forEach { coordArray in
                                var coordinates: [CLLocationCoordinate2D] = []
                                coordArray.forEach { coords in
                                    coordinates.append(CLLocationCoordinate2D(latitude: coords.last!, longitude: coords.first!))
                                }
                                coords.append(coordinates)
                            }
                        default: break
                    }
                    let constructionSite : ConstructionSite = ConstructionSite(name: name, type: type, start: start, end: end, color: color, coords: coords)
                    constructionSites.append(constructionSite)
                }
            }
            return constructionSites
        } catch {
            return constructionSites
        }
    }
}
