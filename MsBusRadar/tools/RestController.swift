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
}
