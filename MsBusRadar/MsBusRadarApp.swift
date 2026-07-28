//
//  MsBusRadarApp.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 20.07.26.
//

import SwiftUI
import SwiftData

@main
struct MsBusRadarApp: App {
    let model : MsBusRadarModel = MsBusRadarModel()
    
    init () {
        do {
            self.model.stopLines = try StopLinesFileParser.loadFromBundle()
        } catch {
            debugPrint("Error reading stop lines text file: \(error)")
        }                
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(self.model)
        }        
    }
}
