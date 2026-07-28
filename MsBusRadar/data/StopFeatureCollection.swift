//
//  StopFeatureCollection.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26.
//

import Foundation


class StopFeatureCollection: Codable {
    var type: String?
    var features: [StopFeatures]?

    private enum CodingKeys: String, CodingKey {
        case type     = "type"
        case features = "features"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type     = try? container.decode(String.self,         forKey: .type)
        features = try? container.decode([StopFeatures].self, forKey: .features)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(type,     forKey: .type)
        try? container.encode(features, forKey: .features)
    }
}

class StopFeatures: Codable {
    var type       : String?
    var geometry   : StopGeometry?
    var properties : StopFeatureProperties?

    private enum CodingKeys: String, CodingKey {
        case type       = "type"
        case geometry   = "geometry"
        case properties = "properties"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type       = try? container.decode(String.self,                forKey: .type)
        geometry   = try? container.decode(StopGeometry.self,          forKey: .geometry)
        properties = try? container.decode(StopFeatureProperties.self, forKey: .properties)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(type,       forKey: .type)
        try? container.encode(geometry,   forKey: .geometry)
        try? container.encode(properties, forKey: .properties)
    }
}

class StopGeometry: Codable {
    var coordinates : [Double]?
    var type        : String?

    private enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case type        = "type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coordinates = try? container.decode([Double].self, forKey: .coordinates)
        type        = try? container.decode(String.self,   forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(coordinates, forKey: .coordinates)
        try? container.encode(type,        forKey: .type)
    }
}

class StopFeatureProperties: Codable {
    var lbez     : String?
    var kbez     : String?
    var richtung : String?
    var nr       : String?
    var globalId : String?

    private enum CodingKeys: String, CodingKey {
        case lbez     = "lbez"
        case kbez     = "kbez"
        case richtung = "richtung"
        case nr       = "nr"
        case globalId = "global_id"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lbez     = try? container.decode(String.self, forKey: .lbez)
        kbez     = try? container.decode(String.self, forKey: .kbez)
        richtung = try? container.decode(String.self, forKey: .richtung)
        nr       = try? container.decode(String.self, forKey: .nr)
        globalId = try? container.decode(String.self, forKey: .globalId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(lbez,     forKey: .lbez)
        try? container.encode(kbez,     forKey: .kbez)
        try? container.encode(richtung, forKey: .richtung)
        try? container.encode(nr,       forKey: .nr)
        try? container.encode(globalId, forKey: .globalId)
    }
}
