//
//  ParkingGarageXMLParser.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 26.07.26.
//
import Foundation
import CoreLocation


final class ParkingGarageXMLParser: NSObject, XMLParserDelegate {
    private var parkingGarages : [ParkingGarage]    = []
    private var currentElement : String             = ""
    private var currentValue   : String             = ""

    private var name           : String             = ""
    private var total          : Int                = 0
    private var free           : Int                = 0
    private var state          : ParkingGarageState = .keineAngabe
    private var timestamp      : String             = ""

    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        df.locale     = Locale(identifier: "de_DE")
        df.timeZone   = TimeZone(identifier: "Europe/Berlin")
        return df
    }()

    
    
    func parse(data: Data) throws -> [ParkingGarage] {
        parkingGarages = []
        
        let parser = XMLParser(data: data)
        parser.delegate = self
        
        if !parser.parse() {
            throw parser.parserError ?? NSError(domain: "ParkingGarageXMLParser", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown XML parsing error"])
        }
        return parkingGarages
    }

    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName
        currentValue   = ""

        if elementName == "parkhaus" {
            name      = ""
            total     = 0
            free      = 0
            state     = .keineAngabe
            timestamp = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue += string
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let trimmed = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)

        switch elementName {
            case "bezeichnung" : name      = trimmed
            case "gesamt"      : total     = Int(trimmed) ?? 0
            case "frei"        : free      = Int(trimmed) ?? 0
            case "status"      : state     = ParkingGarageState.fromText(text: trimmed)
            case "zeitstempel" : timestamp = trimmed
            case "parkhaus"    :
                let date : Date                   = dateFormatter.date(from: timestamp) ?? Date.distantPast
                let p    : ParkingGarage          = ParkingGarage(name: name, totalSpaces: total, freeSpaces: free, state: state, timestamp: date)
                let c    : CLLocationCoordinate2D = Constants.PARKING_GARAGE_LOCATIONS[name] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                p.coordinate = c
                parkingGarages.append(p)
            default            : break
        }
    }
}
