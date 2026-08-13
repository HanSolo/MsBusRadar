//
//  ChargingStations.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 01.08.26.
//

import Foundation


class EChargingStations: Codable {
    var meta: Meta?
    var data: ChargingData?

    private enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case data = "data"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meta = try? container.decode(Meta.self,         forKey: .meta)
        data = try? container.decode(ChargingData.self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(meta, forKey: .meta)
        try? container.encode(data, forKey: .data)
    }
}

class ChargingData: Codable {
    var ags           : String?
    var source        : String?
    var recordId      : String?
    var attribution   : Attribution?
    var schemaVersion : Int?
    var wikidataQid   : String?
    var geo           : String?
    var contentHash   : String?
    var retrievedAt   : String?
    var payload       : ChargingPayload?
    var citySlug      : String?
    var observedAt    : String?
    var licenseTier   : String?
    var licenseId     : String?

    private enum CodingKeys: String, CodingKey {
        case ags           = "ags"
        case source        = "source"
        case recordId      = "record_id"
        case attribution   = "attribution"
        case schemaVersion = "schema_version"
        case wikidataQid   = "wikidata_qid"
        case geo           = "geo"
        case contentHash   = "content_hash"
        case retrievedAt   = "retrieved_at"
        case payload       = "payload"
        case citySlug      = "city_slug"
        case observedAt    = "observed_at"
        case licenseTier   = "license_tier"
        case licenseId     = "license_id"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ags           = try? container.decode(String.self,          forKey: .ags)
        source        = try? container.decode(String.self,          forKey: .source)
        recordId      = try? container.decode(String.self,          forKey: .recordId)
        attribution   = try? container.decode(Attribution.self,     forKey: .attribution)
        schemaVersion = try? container.decode(Int.self,             forKey: .schemaVersion)
        wikidataQid   = try? container.decode(String.self,          forKey: .wikidataQid)
        geo           = try? container.decode(String.self,          forKey: .geo)
        contentHash   = try? container.decode(String.self,          forKey: .contentHash)
        retrievedAt   = try? container.decode(String.self,          forKey: .retrievedAt)
        payload       = try? container.decode(ChargingPayload.self, forKey: .payload)
        citySlug      = try? container.decode(String.self,          forKey: .citySlug)
        observedAt    = try? container.decode(String.self,          forKey: .observedAt)
        licenseTier   = try? container.decode(String.self,          forKey: .licenseTier)
        licenseId     = try? container.decode(String.self,          forKey: .licenseId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(ags,           forKey: .ags)
        try? container.encode(source,        forKey: .source)
        try? container.encode(recordId,      forKey: .recordId)
        try? container.encode(attribution,   forKey: .attribution)
        try? container.encode(schemaVersion, forKey: .schemaVersion)
        try? container.encode(wikidataQid,   forKey: .wikidataQid)
        try? container.encode(geo,           forKey: .geo)
        try? container.encode(contentHash,   forKey: .contentHash)
        try? container.encode(retrievedAt,   forKey: .retrievedAt)
        try? container.encode(payload,       forKey: .payload)
        try? container.encode(citySlug,      forKey: .citySlug)
        try? container.encode(observedAt,    forKey: .observedAt)
        try? container.encode(licenseTier,   forKey: .licenseTier)
        try? container.encode(licenseId,     forKey: .licenseId)
    }
}

class ChargingPayload: Codable {
    var stations : [ChargingStations]?
    var kind     : String?
    var count    : Int?

    private enum CodingKeys: String, CodingKey {
        case stations = "stations"
        case kind     = "kind"
        case count    = "count"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stations = try? container.decode([ChargingStations].self, forKey: .stations)
        kind     = try? container.decode(String.self,             forKey: .kind)
        count    = try? container.decode(Int.self,                forKey: .count)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(stations, forKey: .stations)
        try? container.encode(kind,     forKey: .kind)
        try? container.encode(count,    forKey: .count)
    }
}

public class ChargingStations: Codable {
    var plz          : String?
    var points       : Int?
    var postCode     : String?
    var lon          : Double?
    var place        : String?
    var powerKw      : Double?
    var status       : String?
    var oprtr        : String?
    var lat          : Double?
    var ort          : String?
    var connectors   : [Connector]?
    var stationId    : String?
    var chargingType : String?

    private enum CodingKeys: String, CodingKey {
        case plz          = "plz"
        case points       = "points"
        case postCode     = "post_code"
        case lon          = "lon"
        case place        = "place"
        case powerKw      = "power_kw"
        case status       = "status"
        case oprtr        = "operator" // maybe needs to be operator
        case lat          = "lat"
        case ort          = "ort"
        case connectors   = "connectors"
        case stationId    = "station_id"
        case chargingType = "charging_type"
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        plz          = try? container.decode(String.self,      forKey: .plz)
        points       = try? container.decode(Int.self,         forKey: .points)
        postCode     = try? container.decode(String.self,      forKey: .postCode)
        lon          = try? container.decode(Double.self,      forKey: .lon)
        place        = try? container.decode(String.self,      forKey: .place)
        powerKw      = try? container.decode(Double.self,      forKey: .powerKw)
        status       = try? container.decode(String.self,      forKey: .status)
        oprtr        = try? container.decode(String.self,      forKey: .oprtr)
        lat          = try? container.decode(Double.self,      forKey: .lat)
        ort          = try? container.decode(String.self,      forKey: .ort)
        connectors   = try? container.decode([Connector].self, forKey: .connectors)
        stationId    = try? container.decode(String.self,      forKey: .stationId)
        chargingType = try? container.decode(String.self,      forKey: .chargingType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(plz,          forKey: .plz)
        try? container.encode(points,       forKey: .points)
        try? container.encode(postCode,     forKey: .postCode)
        try? container.encode(lon,          forKey: .lon)
        try? container.encode(place,        forKey: .place)
        try? container.encode(powerKw,      forKey: .powerKw)
        try? container.encode(status,       forKey: .status)
        try? container.encode(oprtr,        forKey: .oprtr)
        try? container.encode(lat,          forKey: .lat)
        try? container.encode(ort,          forKey: .ort)
        try? container.encode(connectors,   forKey: .connectors)
        try? container.encode(stationId,    forKey: .stationId)
        try? container.encode(chargingType, forKey: .chargingType)
    }
}

public class Connector: Codable, Hashable {
    var id      : String
    var powerKw : Double?
    var type    : String?

    private enum CodingKeys: String, CodingKey {
        case powerKw = "power_kw"
        case type    = "type"
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id      = UUID().uuidString
        powerKw = try? container.decode(Double.self, forKey: .powerKw)
        type    = try? container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(powerKw, forKey: .powerKw)
        try? container.encode(type,    forKey: .type)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(powerKw)
        hasher.combine(type)
    }
    
    public static func == (lhs: Connector, rhs: Connector) -> Bool {
        return lhs.id == rhs.id
    }
}
