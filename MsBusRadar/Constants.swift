//
//  Constants.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26.
//

import Foundation
import SwiftUI
import MapKit


public struct Constants {
    public static let APP_NAME                   : String                 = "MsBusRadar"
    public static let APP_GROUP_ID               : String                 = "group.eu.hansolo.MsBusRadar"
    public static let CONTAINER_ID               : String                 = "iCloud.eu.hansolo.MsBusRadarContainer"
    
    public static let BUS_API_URL                : String                 = "https://rest.busradar.conterra.de/prod/fahrzeuge"
    public static let STOP_API_URL               : String                 = "https://rest.busradar.conterra.de/prod/haltestellen" // 4100006/abfahrten?sekunden=1200
    
    public static let PLS_URL                    : String                 = "https://www.stadt-muenster.de/ms/tiefbauamt/pls/PLS-INet.xml"
    public static let FUEL_PRICE_URL             : String                 = "https://infranode.dev/api/v1/cities/muenster/fuel-prices"
    public static let CHARGING_STATIONS_URL      : String                 = "https://infranode.dev/api/v1/cities/muenster/charging"
    public static let FUEL_STATIONS_URL          : String                 = "https://creativecommons.tankerkoenig.de/json/list.php?lat=51.9503314&lng=7.6320715&rad=20&sort=dist&type=all&apikey=d592b089-d4bc-411b-a195-511347a45fd8"
    
    public static let HBF_STATION_URL            : String                 = "https://dbf.finalrewind.org/M%C3%BCnster(Westf)Hbf?detailed=1"
    public static let NORTH_STATION_URL          : String                 = "https://dbf.finalrewind.org/M%C3%BCnster(W)Zentrum%20Nord?detailed=1"
    public static let HILTRUP_STATION_URL        : String                 = "https://dbf.finalrewind.org/M%C3%BCnster-Hiltrup?detailed=1"
    public static let AMELSBUEREN_STATION_URL    : String                 = "https://dbf.finalrewind.org/M%C3%BCnster-Amelsb%C3%BCren?detailed=1"
    public static let ALBACHTEN_STATION_URL      : String                 = "https://dbf.finalrewind.org/M%C3%BCnster-Albachten?detailed=1"
    //public static let HAEGER_STATION_URL       : String                 = "https://dbf.finalrewind.org/M%C3%BCnster-H%C3%A4ger?detailed=1"
    public static let MECKLENBECK_STATION_URL    : String                 = "https://dbf.finalrewind.org/M%C3%BCnster-Mecklenbeck?detailed=1"
    public static let ROXEL_STATION_URL          : String                 = "https://dbf.finalrewind.org/M%C3%BCnster-Roxel?detailed=1"
    public static let SPRAKEL_STATION_URL        : String                 = "https://dbf.finalrewind.org/M%C3%BCnster-Sprakel?detailed=1"
    
    public static let CONSTRUCTION_SITE_URL      : String                 = "https://geo.stadt-muenster.de/mapserv/odbaustellen_serv?SERVICE=WFS&VERSION=1.1.0&REQUEST=GetFeature&TYPENAME=baustellen&OUTPUTFORMAT=geojson&SRSNAME=EPSG:4326"
    
    public static let CONSTRUCTION_SITE_DTF      : DateFormatter          = {
        let formatter : DateFormatter = DateFormatter()
        formatter.locale     = Locale(identifier: "en_US_POSIX")
        formatter.timeZone   = TimeZone(secondsFromGMT: 0) // change if needed
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }()
    public static let DATE_FORMATTER             : DateFormatter          = {
        let formatter : DateFormatter = DateFormatter()        
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    public static let MAP_CENTER                 : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.9503314, longitude: 7.6320715)
    public static let MAP_SPAN                   : MKCoordinateSpan       = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
    
    public static let MAIN_STATION_COORDS        : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.95679125423829, longitude: 7.6355904875809975)
    public static let NORTH_STATION_COORDS       : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.984218996498974, longitude: 7.638610852886908)
    public static let HILTRUP_STATION_COORDS     : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.90476927984736, longitude: 7.654313008652946)
    public static let AMELSBUEREN_STATION_COORDS : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.88463775837982, longitude: 7.599249797881432)
    public static let ALBACHTEN_STATION_COORDS   : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.91458730304542, longitude: 7.52848384959653)
    public static let MECKLENBECK_STATION_COORDS : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.924064260869116, longitude: 7.57863310283584)
    public static let ROXEL_STATION_COORDS       : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.9464277518416, longitude: 7.5261112201067375)
    public static let SPRAKEL_STATION_COORDS     : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.04104541504447, longitude: 7.62046285859722)
    
    public static let BLUE                       : Color                  = Color(red: 0.03, green: 0.67, blue: 0.93, opacity: 1.00)
    public static let DARK_BLUE                  : Color                  = Color(red: 0.01, green: 0.27, blue: 0.53, opacity: 1.00)
    public static let STOP_YELLOW                : Color                  = Color(red: 0.91, green: 0.74, blue: 0.00, opacity: 1.00)
    public static let STOP_GREEN                 : Color                  = Color(red: 0.04, green: 0.47, blue: 0.29, opacity: 1.00)
    public static let SELECTION_COLOR            : Color                  = .orange
    public static let PARK_BLUE                  : Color                  = Color(red: 0.02, green: 0.44, blue: 0.72, opacity: 1.00)
    public static let PARK_GREEN                 : Color                  = Color(red: 0.08, green: 0.96, blue: 0.11, opacity: 1.00)
    public static let DELAY_RED                  : Color                  = Color(red: 0.71, green: 0.00, blue: 0.00, opacity: 1.00)
    public static let EV_GREEN                   : Color                  = Color(red: 0.00, green: 0.60, blue: 0.00, opacity: 1.00)
        
    public static let BUS_FONT                   : Font                   = Font.system(size: 12, weight: .regular, design: .rounded)
    public static let BUS_INFO_FONT              : Font                   = Font.system(size: 12, weight: .regular,  design: .rounded)
    public static let INFO_FONT                  : Font                   = Font.system(size: 14, weight: .light,   design: .rounded)
    public static let STOP_FONT                  : Font                   = Font.system(size: 18, weight: .medium, design: .rounded)
    public static let LINE_NR_FONT               : Font                   = Font.system(size: 14, weight: .medium, design: .rounded)
    public static let LINE_ID_FONT               : Font                   = Font.system(size: 14, weight: .light, design: .rounded)
    public static let LINE_TIME_FONT             : Font                   = Font.system(size: 14, weight: .regular, design: .rounded)
    public static let LINE_PEOPLE_FONT           : Font                   = Font.system(size: 14, weight: .regular, design: .rounded)
    public static let TITLE_FONT                 : Font                   = Font.system(size: 22, weight: .medium,  design: .rounded)
    public static let STD_FONT                   : Font                   = Font.system(size: 14, weight: .regular,  design: .rounded)
    public static let TOOLBAR_FONT               : Font                   = Font.system(size: 10, weight: .light, design: .rounded)
    
    public static let DEFAULT_STOP               : Stop                   = Stop(globalId: "none", name: "", nr: "", direction: "", coordinate: MAP_CENTER)
    public static let DEFAULT_BUS                : Bus                    = Bus(busId: "none", line: "", timestamp: -1, currentStopId: "", nextStopId: "", direction: "", delay: -1, directionId: "", coordinate: MAP_CENTER)
    public static let DEFAULT_PARK_AND_RIDE      : ParkAndRide            = ParkAndRide(name: "none", slots: 0, cost: "", openHours: "", coordinate: MAP_CENTER)
    public static let DEFAULT_PARKING_GARAGE     : ParkingGarage          = ParkingGarage(name: "none", totalSpaces: 0, freeSpaces: 0, state: .keineAngabe, timestamp: Date.now)
    public static let DEFAULT_STATION            : Station                = Station()
    public static let DEFAULT_CONSTRUCTION_ITEM  : PolylineItem           = PolylineItem(name: "none", type: "", start: Date(), end: Date(), coords: [], color: .clear)
    public static let DEFAULT_FUEL_STATION       : FuelStation            = FuelStation(id: UUID().uuidString, brand: "none", coordinate: MAP_CENTER)
    public static let DEFAULT_CHARGING_STATION   : ChargingStation        = ChargingStation(id: UUID().uuidString, name: "none", powerKw: 0, state: "", type: "", points: 0, connectors: [], coordinate: MAP_CENTER)
    
    public static let STATIONS                   : [String:String]        = [
        "Münster Hbf"  : HBF_STATION_URL,
        "Zentrum Nord" : NORTH_STATION_URL,
        "Hiltrup"      : HILTRUP_STATION_URL,
        "Amelsbüren"   : AMELSBUEREN_STATION_URL,
        "Albachten"    : ALBACHTEN_STATION_URL,
        "Mecklenbeck"  : MECKLENBECK_STATION_URL,
        "Roxel"        : ROXEL_STATION_URL,
        "Sprakel"      : SPRAKEL_STATION_URL
    ]
    
    public static let ALL_LINES                  : [String]               = [
        "1","2","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","22","33","34","68","161","177","256","320","330","341","391","399","540","552","564","569","570","571","D60","E1","E10","E11","E12","E14","E15","E17","E4","E5","E6","E8","E80","E85","E9","E98","F1","Hä+G","N1","N2","N3","N4","N42","N5","N6","N7","N8","N80","N81","N82","N83","N84","N85","N9","R11","R13","R22","R32","R41","R51","R63","R64","R72","R73","S20","S30","S50","S60","S70","S71","S75","S90","T15","T18","T20","T5","T541","T64","T7A","T8","T80","T81","T82","T83","T84","T85","T87","T9","X90"
    ]
    
    public static let PARK_AND_RIDES             : [ParkAndRide]          = [
        ParkAndRide(name: "Amelsbüren Bahnhof", slots: 28, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.8847, longitude: 7.59991)),
        ParkAndRide(name: "Grevener Straße", slots: 28, cost: "kostenload", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 52.003, longitude: 7.61559)),
        ParkAndRide(name: "Zentrum Nord", slots: 35, cost: "kostenlos", openHours: "töglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9843, longitude: 7.63707)),
        ParkAndRide(name: "Hauptbahnof", slots: 339, cost: "kostenpflichtig", openHours: "Mo - So 6:00 - 24:00 Uhr", coordinate: CLLocationCoordinate2D(latitude: 51.9564, longitude: 7.63576)),
        ParkAndRide(name: "Hiltrup Bahnhof", slots: 74, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9047, longitude: 7.65424)),
        ParkAndRide(name: "Kappenberger Damm", slots: 56, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.89, longitude: 7.5769)),
        ParkAndRide(name: "Nienberge Häger Bahnhof", slots: 14, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 52.022, longitude: 7.56216)),
        ParkAndRide(name: "Preußenstadion", slots: 270, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9321, longitude: 7.62587)),
        ParkAndRide(name: "Roxel Bahnhof", slots: 33, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9461, longitude: 7.52766)),
        ParkAndRide(name: "Weseler Straße", slots: 175, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9364, longitude: 7.60248)),
        ParkAndRide(name: "Wilkinghege", slots: 50, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9837, longitude: 7.58843)),
        ParkAndRide(name: "Nieberdingerstraße", slots: 172, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9446, longitude: 7.64549)),
        ParkAndRide(name: "Albachten Bahnhof", slots: 21, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.9153, longitude: 7.52723)),
        ParkAndRide(name: "Sprakel Bahnhof", slots: 16, cost: "kostenlos", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 52.0417, longitude: 7.61839)),
        ParkAndRide(name: "Hauptbahnhof", slots: 416, cost: "kostenpflichtig", openHours: "täglich durchgehend", coordinate: CLLocationCoordinate2D(latitude: 51.957899, longitude: 7.637888)),
        ParkAndRide(name: "Coesfelder Kreuz", slots: 1000, cost: "kostenpflichtig", openHours: "Sa 8:00 - 23:00 Uhr", coordinate: CLLocationCoordinate2D(latitude: 51.965865, longitude: 7.601047))
    ]
    
    public static let PARKING_GARAGE_LOCATIONS   : [String: CLLocationCoordinate2D] = [
        "Parkhaus Cineplex"           : CLLocationCoordinate2D(latitude: 51.94974012938595,  longitude: 7.6362538790275080),
        "Halle Münsterland P1"        : CLLocationCoordinate2D(latitude: 51.94957963915623,  longitude: 7.636880569269856),
        "Parkhaus Stadthaus 3"        : CLLocationCoordinate2D(latitude: 51.94948242560567,  longitude: 7.641406008317961),
        "Parkhaus Coesfelder Kreuz"   : CLLocationCoordinate2D(latitude: 51.96622514340247,  longitude: 7.6011057687893215),
        "Parkhaus Alter Steinweg"     : CLLocationCoordinate2D(latitude: 51.962134372899634, longitude: 7.631823394602077),
        "Parkplatz Hörster Platz"     : CLLocationCoordinate2D(latitude: 51.96458142987074,  longitude: 7.63203666773916),
        "Parkhaus Theater"            : CLLocationCoordinate2D(latitude: 51.966339423281404, longitude: 7.626521096615782),
        "Parkplatz Hafenmarkt"        : CLLocationCoordinate2D(latitude: 51.95253458807403,  longitude: 7.6446937267546575),
        "Tiefgarage Hafenmarkt"       : CLLocationCoordinate2D(latitude: 51.9532624499428,   longitude: 7.643864238355443),
        "Parkhaus Aegidii"            : CLLocationCoordinate2D(latitude: 51.96024740985968,  longitude: 7.623294433936949),
        "Parkhaus Georgskommende"     : CLLocationCoordinate2D(latitude: 51.959627191658875, longitude: 7.619426413191943),
        "Parkplatz Busparkplatz"      : CLLocationCoordinate2D(latitude: 51.966039245478434, longitude: 7.616802071824687),
        "Parkplatz Schlossplatz Nord" : CLLocationCoordinate2D(latitude: 51.96449351893886,  longitude: 7.617087354290258),
        "Parkplatz Schlossplatz Süd"  : CLLocationCoordinate2D(latitude: 51.96210047139025,  longitude: 7.616625875522785),
        "Parkhaus Bahnhofstraße"      : CLLocationCoordinate2D(latitude: 51.955738629147206, longitude: 7.632980109079654),
        "Parkhaus Bremer Platz"       : CLLocationCoordinate2D(latitude: 51.95779746337162,  longitude: 7.6374778649480115),
        "Parkhaus Engelenschanze"     : CLLocationCoordinate2D(latitude: 51.955913904983234, longitude: 7.631311779428632),
        "Parkhaus Galeria"            : CLLocationCoordinate2D(latitude: 51.96092639837575,  longitude: 7.6301622549920470),
        "Parkhaus Münster-Arkaden"    : CLLocationCoordinate2D(latitude: 51.95981950283676,  longitude: 7.626316324124607),
        "Parkhaus Stubengasse"        : CLLocationCoordinate2D(latitude: 51.95998659300226,  longitude: 7.630151771279584)
    ]    
}
