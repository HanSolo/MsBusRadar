//
//  EvStationInfoView.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 12.08.26.
//

import Foundation
import SwiftUI


struct EvStationInfoView: View {
    @Environment(\.colorScheme)        private var colorScheme
    @Environment(MsBusRadarModel.self) private var model
    @Environment(\.dismiss)            private var dismiss
    
    @State private var chargingStation : ChargingStation
    
    
    init(chargingStation: ChargingStation) {
        self.chargingStation = chargingStation
    }
    
    
    var body: some View {
        ZStack {
            Constants.BLUE
                .ignoresSafeArea(edges: .all)
                
            VStack {
                HStack(spacing: 10) {
                    Spacer()
                    
                    Button("Schliessen") {
                        dismiss()
                    }
                    .buttonStyle(.glass)
                }
                .buttonStyle(.glass)
                .padding()
                
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                    ZStack {
                        Image(systemName: "ev.charger.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(color: .clear, radius: 0, x: 0, y: 0)
                            .foregroundStyle(.white)
                    }
                    Text(self.chargingStation.name)
                        .font(Constants.STOP_FONT)
                        .foregroundStyle(.white)
                    Spacer()
                }
                Text("\(self.chargingStation.type)")
                    .font(Constants.STD_FONT)
                    .foregroundStyle(.white)
                Text("\(self.chargingStation.state)")
                    .font(Constants.STD_FONT)
                    .foregroundStyle(.white)
                                            
                List(self.chargingStation.connectors, id: \.self) { connector in
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 10) {
                            Text("Leistung")
                                .font(Constants.BUS_INFO_FONT)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("\(String(format: "%.1f kW", connector.powerKw ?? 0.0))")
                                .font(Constants.BUS_INFO_FONT)
                                .foregroundStyle(.white)
                        }
                        HStack(spacing: 10) {
                            Text("Typ")
                                .font(Constants.BUS_INFO_FONT)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("\(connector.type ?? "")")
                                .font(Constants.BUS_INFO_FONT)
                                .foregroundStyle(.white)
                        }
                    }
                    .listRowBackground(Constants.BLUE)
                }
                .background(Constants.BLUE)
                .listStyle(.plain)
                .selectionDisabled()
            }
        }
        .onDisappear {
            self.model.deselectAll()
        }
    }
}
