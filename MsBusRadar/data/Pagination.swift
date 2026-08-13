//
//  Pagination.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 01.08.26.
//


import Foundation

class Pagination: Codable {
    var total     : Int?
    var offset    : Int?
    var returned  : Int?
    var truncated : Bool?
    var limit     : String?

    
    private enum CodingKeys: String, CodingKey {
        case total     = "total"
        case offset    = "offset"
        case returned  = "returned"
        case truncated = "truncated"
        case limit     = "limit"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total     = try? container.decode(Int.self,    forKey: .total)
        offset    = try? container.decode(Int.self,    forKey: .offset)
        returned  = try? container.decode(Int.self,    forKey: .returned)
        truncated = try? container.decode(Bool.self,   forKey: .truncated)
        limit     = try? container.decode(String.self, forKey: .limit)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(total,     forKey: .total)
        try? container.encode(offset,    forKey: .offset)
        try? container.encode(returned,  forKey: .returned)
        try? container.encode(truncated, forKey: .truncated)
        try? container.encode(limit,     forKey: .limit)
    }
}