//
//  RoadWork.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 28.07.26.
//

import Foundation


class ConstructionSites: Codable {
    var crs      : Crs?
    var type     : String?
    var name     : String?
    var features : [Features]?

    private enum CodingKeys: String, CodingKey {
        case crs      = "crs"
        case type     = "type"
        case name     = "name"
        case features = "features"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        crs      = try? container.decode(Crs.self,        forKey: .crs)
        type     = try? container.decode(String.self,     forKey: .type)
        name     = try? container.decode(String.self,     forKey: .name)
        features = try? container.decode([Features].self, forKey: .features)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(crs,      forKey: .crs)
        try? container.encode(type,     forKey: .type)
        try? container.encode(name,     forKey: .name)
        try? container.encode(features, forKey: .features)
    }
}

class Crs: Codable {
    var properties : CrsProperties?
    var type       : String?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
        case type       = "type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        properties = try? container.decode(CrsProperties.self, forKey: .properties)
        type       = try? container.decode(String.self,     forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(properties, forKey: .properties)
        try? container.encode(type,       forKey: .type)
    }
}

class CrsProperties: Codable {
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(name, forKey: .name)
    }
}

class Features: Codable {
    var properties : ConstructionSiteProperties?
    var geometry   : Geometry?
    var type       : String?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
        case geometry   = "geometry"
        case type       = "type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        properties = try? container.decode(ConstructionSiteProperties.self, forKey: .properties)
        geometry   = try? container.decode(Geometry.self,   forKey: .geometry)
        type       = try? container.decode(String.self,     forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(properties, forKey: .properties)
        try? container.encode(geometry,   forKey: .geometry)
        try? container.encode(type,       forKey: .type)
    }
}

class ConstructionSiteProperties: Codable {
    var telefonansprechpartner1 : String?
    var mobil11                 : String?
    var mobil2                  : String?
    var vorname1                : String?
    var typId                   : Int?
    var bezeichnung             : String?
    var gesamtname2             : String?
    var telefon1                : String?
    var telefon2                : String?
    var publikationvon          : String?
    var information             : String?
    var telefonansprechpartner2 : String?
    var fuid                    : Int?
    var firmenname2             : String?
    var endetam                 : String?
    var beginntam               : String?
    var nachname2               : String?
    var firmenname1             : String?
    var typBez                  : String?
    var gesamtname1             : String?
    var vorname2                : String?
    var publikationbis          : String?
    var nachname1               : String?

    private enum CodingKeys: String, CodingKey {
        case telefonansprechpartner1 = "telefonansprechpartner1"
        case mobil11                 = "mobil11"
        case mobil2                  = "mobil2"
        case vorname1                = "vorname1"
        case typId                   = "typ_id"
        case bezeichnung             = "bezeichnung"
        case gesamtname2             = "gesamtname2"
        case telefon1                = "telefon1"
        case telefon2                = "telefon2"
        case publikationvon          = "publikationvon"
        case information             = "information"
        case telefonansprechpartner2 = "telefonansprechpartner2"
        case fuid                    = "fuid"
        case firmenname2             = "firmenname2"
        case endetam                 = "endetam"
        case beginntam               = "beginntam"
        case nachname2               = "nachname2"
        case firmenname1             = "firmenname1"
        case typBez                  = "typ_bez"
        case gesamtname1             = "gesamtname1"
        case vorname2                = "vorname2"
        case publikationbis          = "publikationbis"
        case nachname1               = "nachname1"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        telefonansprechpartner1 = try? container.decode(String.self, forKey: .telefonansprechpartner1)
        mobil11                 = try? container.decode(String.self, forKey: .mobil11)
        mobil2                  = try? container.decode(String.self, forKey: .mobil2)
        vorname1                = try? container.decode(String.self, forKey: .vorname1)
        typId                   = try? container.decode(Int.self,    forKey: .typId)
        bezeichnung             = try? container.decode(String.self, forKey: .bezeichnung)
        gesamtname2             = try? container.decode(String.self, forKey: .gesamtname2)
        telefon1                = try? container.decode(String.self, forKey: .telefon1)
        telefon2                = try? container.decode(String.self, forKey: .telefon2)
        publikationvon          = try? container.decode(String.self, forKey: .publikationvon)
        information             = try? container.decode(String.self, forKey: .information)
        telefonansprechpartner2 = try? container.decode(String.self, forKey: .telefonansprechpartner2)
        fuid                    = try? container.decode(Int.self,    forKey: .fuid)
        firmenname2             = try? container.decode(String.self, forKey: .firmenname2)
        endetam                 = try? container.decode(String.self, forKey: .endetam)
        beginntam               = try? container.decode(String.self, forKey: .beginntam)
        nachname2               = try? container.decode(String.self, forKey: .nachname2)
        firmenname1             = try? container.decode(String.self, forKey: .firmenname1)
        typBez                  = try? container.decode(String.self, forKey: .typBez)
        gesamtname1             = try? container.decode(String.self, forKey: .gesamtname1)
        vorname2                = try? container.decode(String.self, forKey: .vorname2)
        publikationbis          = try? container.decode(String.self, forKey: .publikationbis)
        nachname1               = try? container.decode(String.self, forKey: .nachname1)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(telefonansprechpartner1, forKey: .telefonansprechpartner1)
        try? container.encode(mobil11,                 forKey: .mobil11)
        try? container.encode(mobil2,                  forKey: .mobil2)
        try? container.encode(vorname1,                forKey: .vorname1)
        try? container.encode(typId,                   forKey: .typId)
        try? container.encode(bezeichnung,             forKey: .bezeichnung)
        try? container.encode(gesamtname2,             forKey: .gesamtname2)
        try? container.encode(telefon1,                forKey: .telefon1)
        try? container.encode(telefon2,                forKey: .telefon2)
        try? container.encode(publikationvon,          forKey: .publikationvon)
        try? container.encode(information,             forKey: .information)
        try? container.encode(telefonansprechpartner2, forKey: .telefonansprechpartner2)
        try? container.encode(fuid,                    forKey: .fuid)
        try? container.encode(firmenname2,             forKey: .firmenname2)
        try? container.encode(endetam,                 forKey: .endetam)
        try? container.encode(beginntam,               forKey: .beginntam)
        try? container.encode(nachname2,               forKey: .nachname2)
        try? container.encode(firmenname1,             forKey: .firmenname1)
        try? container.encode(typBez,                  forKey: .typBez)
        try? container.encode(gesamtname1,             forKey: .gesamtname1)
        try? container.encode(vorname2,                forKey: .vorname2)
        try? container.encode(publikationbis,          forKey: .publikationbis)
        try? container.encode(nachname1,               forKey: .nachname1)
    }
}

class Geometry: Codable {
    var coordinates : [[Double]]?
    var line        : [[Double]]?
    var multiLine   : [[[Double]]]?
    var type        : String?

    private enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case type        = "type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coordinates = try? container.decode([[Double]].self,  forKey: .coordinates)
        line        = try? container.decode([[Double]].self,  forKey: .coordinates)
        multiLine   = try? container.decode([[[Double]]].self,  forKey: .coordinates)        
        type        = try? container.decode(String.self, forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(coordinates, forKey: .coordinates)
        try? container.encode(type,        forKey: .type)
    }
}
