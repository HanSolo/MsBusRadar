//
//  Attribution.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 01.08.26.
//


import Foundation

class Attribution: Codable {
    var modified   : Bool?
    var licenseUrl : String?
    var text       : String?

    private enum CodingKeys: String, CodingKey {
        case modified   = "modified"
        case licenseUrl = "license_url"
        case text       = "text"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        modified   = try? container.decode(Bool.self,   forKey: .modified)
        licenseUrl = try? container.decode(String.self, forKey: .licenseUrl)
        text       = try? container.decode(String.self, forKey: .text)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(modified,   forKey: .modified)
        try? container.encode(licenseUrl, forKey: .licenseUrl)
        try? container.encode(text,       forKey: .text)
    }
}