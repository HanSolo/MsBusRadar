//
//  Item.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 20.07.26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
