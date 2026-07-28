//
//  RestController.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 08.05.26.
//

import Foundation


enum StopLinesFileParser {

    enum ParseError: Error {
        case fileNotFound(String)
        case fileNotReadable
    }

    
    static func loadFromBundle(filename: String = "haltestellen_linien_muenster", fileExtension: String = "txt", bundle: Bundle = .main) throws -> [String: [String]] {
        guard let url = bundle.url(forResource: filename, withExtension: fileExtension) else {
            throw ParseError.fileNotFound("\(filename).\(fileExtension)")
        }
        return try parse(fileAt: url)
    }

    static func parse(fileAt url: URL) throws -> [String: [String]] {
        guard let content = try? String(contentsOf: url, encoding: .utf8) else {
            throw ParseError.fileNotReadable
        }
        return parse(content: content)
    }

    static func parse(content: String) -> [String: [String]] {
        var result: [String: [String]] = [:]

        content.enumerateLines { line, _ in
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { return }

            // Format: "stop_id: linie1,linie2,linie3"
            guard let separatorRange = trimmed.range(of: ": ") else { return }

            let stopId    = String(trimmed[trimmed.startIndex..<separatorRange.lowerBound])
            let linesPart = String(trimmed[separatorRange.upperBound...])

            let lines = linesPart.split(separator: ",")
                                 .map { $0.trimmingCharacters(in: .whitespaces) }
                                 .filter { !$0.isEmpty }

            guard !stopId.isEmpty, !lines.isEmpty else { return }
            result[stopId] = lines
        }

        return result
    }
}
