//
//  FuelPrices.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 01.08.26.
//

import Foundation


class FuelPrices: Codable {
    var status   : String?
    var data     : String?
    var stations : [FuelStations]?
    var license  : String?
    var ok       : Bool?

    private enum CodingKeys: String, CodingKey {
        case status   = "status"
        case data     = "data"
        case stations = "stations"
        case license  = "license"
        case ok       = "ok"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status   = try? container.decode(String.self,         forKey: .status)
        data     = try? container.decode(String.self,         forKey: .data)
        stations = try? container.decode([FuelStations].self, forKey: .stations)
        license  = try? container.decode(String.self,         forKey: .license)
        ok       = try? container.decode(Bool.self,           forKey: .ok)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(status,   forKey: .status)
        try? container.encode(data,     forKey: .data)
        try? container.encode(stations, forKey: .stations)
        try? container.encode(license,  forKey: .license)
        try? container.encode(ok,       forKey: .ok)
    }
}

class FuelStations: Codable {
    var e10         : Double?
    var street      : String?
    var dist        : Double?
    var e5          : Double?
    var name        : String?
    var brand       : String?
    var postCode    : Int?
    var place       : String?
    var id          : String?
    var lat         : Double?
    var houseNumber : String?
    var isOpen      : Bool?
    var lng         : Double?
    var diesel      : Double?

    private enum CodingKeys: String, CodingKey {
        case e10         = "e10"
        case street      = "street"
        case dist        = "dist"
        case e5          = "e5"
        case name        = "name"
        case brand       = "brand"
        case postCode    = "postCode"
        case place       = "place"
        case id          = "id"
        case lat         = "lat"
        case houseNumber = "houseNumber"
        case isOpen      = "isOpen"
        case lng         = "lng"
        case diesel      = "diesel"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        e10         = try? container.decode(Double.self, forKey: .e10)
        street      = try? container.decode(String.self, forKey: .street)
        dist        = try? container.decode(Double.self, forKey: .dist)
        e5          = try? container.decode(Double.self, forKey: .e5)
        name        = try? container.decode(String.self, forKey: .name)
        brand       = try? container.decode(String.self, forKey: .brand)
        postCode    = try? container.decode(Int.self,    forKey: .postCode)
        place       = try? container.decode(String.self, forKey: .place)
        id          = try? container.decode(String.self, forKey: .id)
        lat         = try? container.decode(Double.self, forKey: .lat)
        houseNumber = try? container.decode(String.self, forKey: .houseNumber)
        isOpen      = try? container.decode(Bool.self,   forKey: .isOpen)
        lng         = try? container.decode(Double.self, forKey: .lng)
        diesel      = try? container.decode(Double.self, forKey: .diesel)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(e10,         forKey: .e10)
        try? container.encode(street,      forKey: .street)
        try? container.encode(dist,        forKey: .dist)
        try? container.encode(e5,          forKey: .e5)
        try? container.encode(name,        forKey: .name)
        try? container.encode(brand,       forKey: .brand)
        try? container.encode(postCode,    forKey: .postCode)
        try? container.encode(place,       forKey: .place)
        try? container.encode(id,          forKey: .id)
        try? container.encode(lat,         forKey: .lat)
        try? container.encode(houseNumber, forKey: .houseNumber)
        try? container.encode(isOpen,      forKey: .isOpen)
        try? container.encode(lng,         forKey: .lng)
        try? container.encode(diesel,      forKey: .diesel)
    }
}
