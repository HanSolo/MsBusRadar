//
//  Meta.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 01.08.26.
//


import Foundation

class Meta: Codable {
    var pagination    : Pagination?
    var sourceStatus  : String?
    var correlationId : String?

    private enum CodingKeys: String, CodingKey {
        case pagination    = "pagination"
        case sourceStatus  = "source_status"
        case correlationId = "correlation_id"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pagination    = try? container.decode(Pagination.self, forKey: .pagination)
        sourceStatus  = try? container.decode(String.self,     forKey: .sourceStatus)
        correlationId = try? container.decode(String.self,     forKey: .correlationId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(pagination,    forKey: .pagination)
        try? container.encode(sourceStatus,  forKey: .sourceStatus)
        try? container.encode(correlationId, forKey: .correlationId)
    }
}