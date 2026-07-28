//
//  Station.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 28.07.26.
//

import Foundation


public class Station: Codable {
    var departures: [Departures]?

    private enum CodingKeys: String, CodingKey {
        case departures = "departures"
    }

    init() {
        self.departures = []
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        departures = try? container.decode([Departures].self, forKey: .departures)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(departures, forKey: .departures)
    }
}

public class Departures: Codable, Identifiable, Hashable, Equatable {
    private(set) public var id  : String
    var scheduledPlatform  : String?
    var delayDeparture     : Int?
    var route              : [Route]?
    var platform           : String?
    var messages           : Messages?
    var train              : String?
    var trainNumber        : String?
    var scheduledArrival   : String?
    var scheduledDeparture : String?
    var via                : [Int]?
    var isCancelled        : Int?
    var trainClasses       : [String]?
    var missingRealtime    : Bool?
    var destination        : String?
    var delayArrival       : Int?

    private enum CodingKeys: String, CodingKey {
        case scheduledPlatform  = "scheduledPlatform"
        case delayDeparture     = "delayDeparture"
        case route              = "route"
        case platform           = "platform"
        case messages           = "messages"
        case train              = "train"
        case trainNumber        = "trainNumber"
        case scheduledArrival   = "scheduledArrival"
        case scheduledDeparture = "scheduledDeparture"
        case via                = "via"
        case isCancelled        = "isCancelled"
        case trainClasses       = "trainClasses"
        case missingRealtime    = "missingRealtime"
        case destination        = "destination"
        case delayArrival       = "delayArrival"
    }

    required public init(from decoder: Decoder) throws {
        self.id            = UUID().uuidString
        let container = try decoder.container(keyedBy: CodingKeys.self)
        scheduledPlatform  = try? container.decode(String.self,   forKey: .scheduledPlatform)
        delayDeparture     = try? container.decode(Int.self,      forKey: .delayDeparture)
        route              = try? container.decode([Route].self,  forKey: .route)
        platform           = try? container.decode(String.self,   forKey: .platform)
        messages           = try? container.decode(Messages.self, forKey: .messages)
        train              = try? container.decode(String.self,   forKey: .train)
        trainNumber        = try? container.decode(String.self,   forKey: .trainNumber)
        scheduledArrival   = try? container.decode(String.self,   forKey: .scheduledArrival)
        scheduledDeparture = try? container.decode(String.self,   forKey: .scheduledDeparture)
        via                = try? container.decode([Int].self,    forKey: .via)
        isCancelled        = try? container.decode(Int.self,      forKey: .isCancelled)
        trainClasses       = try? container.decode([String].self, forKey: .trainClasses)
        missingRealtime    = try? container.decode(Bool.self,     forKey: .missingRealtime)
        destination        = try? container.decode(String.self,   forKey: .destination)
        delayArrival       = try? container.decode(Int.self,      forKey: .delayArrival)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(scheduledPlatform,  forKey: .scheduledPlatform)
        try? container.encode(delayDeparture,     forKey: .delayDeparture)
        try? container.encode(route,              forKey: .route)
        try? container.encode(platform,           forKey: .platform)
        try? container.encode(messages,           forKey: .messages)
        try? container.encode(train,              forKey: .train)
        try? container.encode(trainNumber,        forKey: .trainNumber)
        try? container.encode(scheduledArrival,   forKey: .scheduledArrival)
        try? container.encode(scheduledDeparture, forKey: .scheduledDeparture)
        try? container.encode(via,                forKey: .via)
        try? container.encode(isCancelled,        forKey: .isCancelled)
        try? container.encode(trainClasses,       forKey: .trainClasses)
        try? container.encode(missingRealtime,    forKey: .missingRealtime)
        try? container.encode(destination,        forKey: .destination)
        try? container.encode(delayArrival,       forKey: .delayArrival)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(train!)
        hasher.combine(trainNumber!)
    }
    
    public static func == (lhs: Departures, rhs: Departures) -> Bool {
        return lhs.train == rhs.train && lhs.trainNumber == rhs.trainNumber
    }
}

class Route: Codable {
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

class Messages: Codable {
    var delay : [Delay]?
    var qos   : [Int]?

    private enum CodingKeys: String, CodingKey {
        case delay = "delay"
        case qos   = "qos"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        delay = try? container.decode([Delay].self, forKey: .delay)
        qos   = try? container.decode([Int].self, forKey: .qos)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(delay, forKey: .delay)
        try? container.encode(qos,   forKey: .qos)
    }
}

class Delay: Codable {
    var text      : String?
    var timestamp : String?

    private enum CodingKeys: String, CodingKey {
        case text      = "text"
        case timestamp = "timestamp"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text      = try? container.decode(String.self, forKey: .text)
        timestamp = try? container.decode(String.self, forKey: .timestamp)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(text,      forKey: .text)
        try? container.encode(timestamp, forKey: .timestamp)
    }
}
