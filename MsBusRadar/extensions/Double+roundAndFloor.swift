//
//  Double+roundAndFloor.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 20.07.26.
//

import Foundation


extension Double {
    func round(nearest: Double) -> Double {
        let n             = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }

    func floor(nearest: Double) -> Double {
        let intDiv = Double(Int(self / nearest))
        return intDiv * nearest
    }
}
