//
//  StopInfoOverview.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 20.07.26.
//

import Foundation
import SwiftUI


struct StopInfoOverview: View {
    @Environment(\.colorScheme)        private var colorScheme
    @Environment(MsBusRadarModel.self) private var model
    @Environment(\.dismiss)            private var dismiss
    
    @State private var stop      : Stop
    @State private var stopInfos : [StopInfoView]    = []
    
    
    init(stop: Stop) {
        self.stop = stop
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
                        Image(systemName: "h.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(color: .clear, radius: 0, x: 0, y: 0)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Constants.STOP_GREEN, Constants.STOP_YELLOW)
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(color: .clear, radius: 0, x: 0, y: 0)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Constants.STOP_GREEN)
                    }
                    Text(self.stop.name)
                        .font(Constants.STOP_FONT)
                        .foregroundStyle(.white)
                    
                    let isFavorite : Bool = self.model.favoriteStops.contains(stop.globalId)
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundStyle(.white)
                        .onTapGesture {
                            if isFavorite {
                                self.model.favoriteStops.removeAll(where: { $0 == stop.globalId })
                            } else {
                                self.model.favoriteStops.append(stop.globalId)
                            }
                        }
                    
                    Spacer()
                }
                
                Text("(\(stop.direction))")
                    .font(Constants.INFO_FONT)
                    .foregroundStyle(.white)
                
                Text("Linien in den nächsten 20 min")
                    .font(Constants.INFO_FONT)
                    .foregroundStyle(.white)
                
                List(self.stopInfos, id: \.self) { info in
                    info
                        .listRowBackground(Constants.BLUE)
                }
                .background(Constants.BLUE)
                .listStyle(.plain)
                .selectionDisabled()
            }
        }        
        .task {
            let stopInfos : [StopInfoView] = await getBusStopInfoView(stopId: stop.nr)
            self.stopInfos.removeAll()
            self.stopInfos += stopInfos
        }
    }
    
    private func getBusStopInfoView(stopId: String) async -> [StopInfoView] {
        var infos     : [StopInfoView] = []
        let stopInfos : [StopInfo]     = await RestController.getStopInfo(stopId: stopId)
        stopInfos.forEach { stopInfo in
            infos.append(StopInfoView(model: self.model, stopInfo: stopInfo))
        }
        return infos
    }
}
