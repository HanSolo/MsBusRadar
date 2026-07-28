//
//  FeatureCollection.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26.
//

import Foundation


class BusFeatureCollection: Codable {
    var features : [BusFeatures]?
    var type     : String?

    private enum CodingKeys: String, CodingKey {
        case features = "features"
        case type     = "type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        features = try? container.decode([BusFeatures].self, forKey: .features)
        type     = try? container.decode(String.self,     forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(features, forKey: .features)
        try? container.encode(type,     forKey: .type)
    }
}

class BusFeatures: Codable {
    var geometry   : BusGeometry?
    var type       : String?
    var properties : BusFeatureProperties?

    private enum CodingKeys: String, CodingKey {
        case geometry   = "geometry"
        case type       = "type"
        case properties = "properties"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        geometry   = try? container.decode(BusGeometry.self,   forKey: .geometry)
        type       = try? container.decode(String.self,     forKey: .type)
        properties = try? container.decode(BusFeatureProperties.self, forKey: .properties)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(geometry,   forKey: .geometry)
        try? container.encode(type,       forKey: .type)
        try? container.encode(properties, forKey: .properties)
    }
}

class BusGeometry: Codable {
    var coordinates : [Double]?
    var type        : String?

    private enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case type        = "type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coordinates = try? container.decode([Double].self, forKey: .coordinates)
        type = try? container.decode(String.self, forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(coordinates, forKey: .coordinates)
        try? container.encode(type,        forKey: .type)
    }
}

class BusFeatureProperties: Codable {
    var visfahrplanlagezst : Int?
    var sequenz            : Int?
    var nachhst            : String?
    var richtungsid        : String?
    var fahrtbezeichner    : String?
    var delay              : Int?
    var linienid           : String?
    var fahrzeugid         : String?
    var starthst           : String?
    var linientext         : String?
    var zielhst            : String?
    var abfahrtstart       : String?
    var betriebstag        : String?
    var akthst             : String?
    var ankunftziel        : String?
    var fahrtstatus        : String?
    var richtungstext      : String?

    private enum CodingKeys: String, CodingKey {
        case visfahrplanlagezst = "visfahrplanlagezst"
        case sequenz            = "sequenz"
        case nachhst            = "nachhst"
        case richtungsid        = "richtungsid"
        case fahrtbezeichner    = "fahrtbezeichner"
        case delay              = "delay"
        case linienid           = "linienid"
        case fahrzeugid         = "fahrzeugid"
        case starthst           = "starthst"
        case linientext         = "linientext"
        case zielhst            = "zielhst"
        case abfahrtstart       = "abfahrtstart"
        case betriebstag        = "betriebstag"
        case akthst             = "akthst"
        case ankunftziel        = "ankunftziel"
        case fahrtstatus        = "fahrtstatus"
        case richtungstext      = "richtungstext"
    }

    required init(from decoder: Decoder) throws {
        let container      = try decoder.container(keyedBy: CodingKeys.self)
        visfahrplanlagezst = try? container.decode(Int.self,    forKey: .visfahrplanlagezst)
        sequenz            = try? container.decode(Int.self,    forKey: .sequenz)
        nachhst            = try? container.decode(String.self, forKey: .nachhst)
        richtungsid        = try? container.decode(String.self, forKey: .richtungsid)
        fahrtbezeichner    = try? container.decode(String.self, forKey: .fahrtbezeichner)
        delay              = try? container.decode(Int.self,    forKey: .delay)
        linienid           = try? container.decode(String.self, forKey: .linienid)
        fahrzeugid         = try? container.decode(String.self, forKey: .fahrzeugid)
        starthst           = try? container.decode(String.self, forKey: .starthst)
        linientext         = try? container.decode(String.self, forKey: .linientext)
        zielhst            = try? container.decode(String.self, forKey: .zielhst)
        abfahrtstart       = try? container.decode(String.self, forKey: .abfahrtstart)
        betriebstag        = try? container.decode(String.self, forKey: .betriebstag)
        akthst             = try? container.decode(String.self, forKey: .akthst)
        ankunftziel        = try? container.decode(String.self, forKey: .ankunftziel)
        fahrtstatus        = try? container.decode(String.self, forKey: .fahrtstatus)
        richtungstext      = try? container.decode(String.self, forKey: .richtungstext)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(visfahrplanlagezst, forKey: .visfahrplanlagezst)
        try? container.encode(sequenz,            forKey: .sequenz)
        try? container.encode(nachhst,            forKey: .nachhst)
        try? container.encode(richtungsid,        forKey: .richtungsid)
        try? container.encode(fahrtbezeichner,    forKey: .fahrtbezeichner)
        try? container.encode(delay,              forKey: .delay)
        try? container.encode(linienid,           forKey: .linienid)
        try? container.encode(fahrzeugid,         forKey: .fahrzeugid)
        try? container.encode(starthst,           forKey: .starthst)
        try? container.encode(linientext,         forKey: .linientext)
        try? container.encode(zielhst,            forKey: .zielhst)
        try? container.encode(abfahrtstart,       forKey: .abfahrtstart)
        try? container.encode(betriebstag,        forKey: .betriebstag)
        try? container.encode(akthst,             forKey: .akthst)
        try? container.encode(ankunftziel,        forKey: .ankunftziel)
        try? container.encode(fahrtstatus,        forKey: .fahrtstatus)
        try? container.encode(richtungstext,      forKey: .richtungstext)
    }
}
