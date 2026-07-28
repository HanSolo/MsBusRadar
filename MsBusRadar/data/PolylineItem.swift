//
//  PolylineItem.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 28.07.26.
//

import Foundation
import SwiftUI
import CoreLocation


public struct PolylineItem: Identifiable {
    public let id     : UUID = UUID()
    let name   : String
    let type   : String
    let start  : Date
    let end    : Date
    let coords : [CLLocationCoordinate2D]
    let color  : Color
}
