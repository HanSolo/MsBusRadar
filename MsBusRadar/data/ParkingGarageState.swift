//
//  ParkingGarageState.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 26.07.26.
//

import Foundation


public enum ParkingGarageState {
    case geschlossen
    case keineAngabe
    case frei
    
    public func uiString() -> String {
        switch self {
            case .frei        : return "Frei"
            case .geschlossen : return "Geschlossen"
            case .keineAngabe : return "keine Angabe"
        }
    }
    
    public static func fromText(text: String) -> ParkingGarageState {
        switch text.lowercased() {
            case "frei"        : return .frei
            case "geschlossen" : return .geschlossen
            default            : return .keineAngabe
        }
    }
    
}
