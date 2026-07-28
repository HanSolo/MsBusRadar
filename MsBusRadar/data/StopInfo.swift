//
//  StopInfo.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 18.07.26.
//

import Foundation


class StopInfo: Codable, Hashable {
    var tatsaechlicheAnkunftszeit : Int?
    var ankunftszeit              : Int?
    var fahrzeugid                : String?
    var sequenz                   : Int?
    var richtungstext             : String?
    var lbez                      : String?
    var linientext                : String?
    var einsteigeverbot           : String?
    var tatsaechlicheAbfahrtszeit : Int?
    var abfahrtszeit              : Int?
    var fahrtbezeichner           : String?
    var prognosemoeglich          : String?
    var besetztgrad               : String?
    var kbez                      : String?
    var haltid                    : String?
    var delay                     : Int?

    
    private enum CodingKeys: String, CodingKey {
        case tatsaechlicheAnkunftszeit = "tatsaechliche_ankunftszeit"
        case ankunftszeit              = "ankunftszeit"
        case fahrzeugid                = "fahrzeugid"
        case sequenz                   = "sequenz"
        case richtungstext             = "richtungstext"
        case lbez                      = "lbez"
        case linientext                = "linientext"
        case einsteigeverbot           = "einsteigeverbot"
        case tatsaechlicheAbfahrtszeit = "tatsaechliche_abfahrtszeit"
        case abfahrtszeit              = "abfahrtszeit"
        case fahrtbezeichner           = "fahrtbezeichner"
        case prognosemoeglich          = "prognosemoeglich"
        case besetztgrad               = "besetztgrad"
        case kbez                      = "kbez"
        case haltid                    = "haltid"
        case delay                     = "delay"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tatsaechlicheAnkunftszeit = try? container.decode(Int.self,    forKey: .tatsaechlicheAnkunftszeit)
        ankunftszeit              = try? container.decode(Int.self,    forKey: .ankunftszeit)
        fahrzeugid                = try? container.decode(String.self, forKey: .fahrzeugid)
        sequenz                   = try? container.decode(Int.self,    forKey: .sequenz)
        richtungstext             = try? container.decode(String.self, forKey: .richtungstext)
        lbez                      = try? container.decode(String.self, forKey: .lbez)
        linientext                = try? container.decode(String.self, forKey: .linientext)
        einsteigeverbot           = try? container.decode(String.self, forKey: .einsteigeverbot)
        tatsaechlicheAbfahrtszeit = try? container.decode(Int.self,    forKey: .tatsaechlicheAbfahrtszeit)
        abfahrtszeit              = try? container.decode(Int.self,    forKey: .abfahrtszeit)
        fahrtbezeichner           = try? container.decode(String.self, forKey: .fahrtbezeichner)
        prognosemoeglich          = try? container.decode(String.self, forKey: .prognosemoeglich)
        besetztgrad               = try? container.decode(String.self, forKey: .besetztgrad)
        kbez                      = try? container.decode(String.self, forKey: .kbez)
        haltid                    = try? container.decode(String.self, forKey: .haltid)
        delay                     = try? container.decode(Int.self,    forKey: .delay)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(tatsaechlicheAnkunftszeit, forKey: .tatsaechlicheAnkunftszeit)
        try? container.encode(ankunftszeit,              forKey: .ankunftszeit)
        try? container.encode(fahrzeugid,                forKey: .fahrzeugid)
        try? container.encode(sequenz,                   forKey: .sequenz)
        try? container.encode(richtungstext,             forKey: .richtungstext)
        try? container.encode(lbez,                      forKey: .lbez)
        try? container.encode(linientext,                forKey: .linientext)
        try? container.encode(einsteigeverbot,           forKey: .einsteigeverbot)
        try? container.encode(tatsaechlicheAbfahrtszeit, forKey: .tatsaechlicheAbfahrtszeit)
        try? container.encode(abfahrtszeit,              forKey: .abfahrtszeit)
        try? container.encode(fahrtbezeichner,           forKey: .fahrtbezeichner)
        try? container.encode(prognosemoeglich,          forKey: .prognosemoeglich)
        try? container.encode(besetztgrad,               forKey: .besetztgrad)
        try? container.encode(kbez,                      forKey: .kbez)
        try? container.encode(haltid,                    forKey: .haltid)
        try? container.encode(delay,                     forKey: .delay)
    }
    
    static func == (lhs: StopInfo, rhs: StopInfo) -> Bool {
        return lhs.fahrzeugid == rhs.fahrzeugid &&
               lhs.linientext == rhs.linientext
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(fahrzeugid)
        hasher.combine(linientext)
    }
}
