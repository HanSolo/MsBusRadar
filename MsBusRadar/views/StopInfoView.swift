//
//  StopInfoView.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 18.07.26.
//

import SwiftUI

struct StopInfoView: View, Hashable {
    let timeFormatter : DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    var model    : MsBusRadarModel
    var stopInfo : StopInfo
    
    
    init(model: MsBusRadarModel, stopInfo: StopInfo) {
        self.model    = model
        self.stopInfo = stopInfo
    }
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack {
                Text("Linie \(stopInfo.linientext!)")
                    .font(Constants.LINE_NR_FONT)
                    .foregroundStyle(.white)
                Spacer()
            }
            .frame(width: 100)
            
            if stopInfo.ankunftszeit != nil {
                let planedArrivalTime : TimeInterval = TimeInterval(stopInfo.ankunftszeit!)
                let realArrivalTime   : TimeInterval = TimeInterval(stopInfo.tatsaechlicheAnkunftszeit!)
                let deltaTime         : TimeInterval = realArrivalTime - planedArrivalTime
                let arrivalTime       : Date         = Date.init(timeIntervalSince1970: planedArrivalTime)
                HStack {
                    Text("\(self.timeFormatter.string(for: arrivalTime)!) \(deltaTime > 120 ? " +\((deltaTime / 60).round(nearest: 0.5)) min" : "")")
                        .font(Constants.LINE_TIME_FONT)
                        .foregroundStyle(.white)
                        .overlay(alignment: .leading) {}
                    //Spacer()
                }
                .frame(width: 120)
            }
            Spacer()
            
            if stopInfo.besetztgrad != nil {
                HStack(spacing: 0) {
                    switch stopInfo.besetztgrad! {
                    case "Überfüllt":
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white)
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white)
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white)
                    case "Stark besetzt":
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white)
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white)
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white.opacity(0.5))
                    case "Schwach besetzt":
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white)
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white.opacity(0.5))
                        Image(systemName: "figure.stand")
                            .foregroundStyle(.white.opacity(0.5))
                    default:
                        EmptyView()
                    }
                    Spacer()
                }
                .font(Constants.LINE_PEOPLE_FONT)
                .frame(width: 80)
            }
            
            if stopInfo.fahrzeugid != nil {
                let isSelectedVehicleId : Bool = self.model.selectedBus.id == stopInfo.fahrzeugid!
                ZStack {
                    Image(systemName: isSelectedVehicleId ? "circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .shadow(color: .clear, radius: 0, x: 0, y: 0)
                        .foregroundStyle(isSelectedVehicleId ? Constants.SELECTION_COLOR : .white)
                                                                
                    Image(systemName: "bus.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 10, height: 10)
                        .shadow(color: .clear, radius: 0, x: 0, y: 0)
                }
                .onTapGesture {
                    self.model.selectedParkingGarage = Constants.DEFAULT_PARKING_GARAGE
                    self.model.selectedBus = self.model.busses.first(where: { $0.id == stopInfo.fahrzeugid! }) ?? Constants.DEFAULT_BUS
                    self.model.stopsOfSelectedLine.removeAll()
                    self.model.stopsOfSelectedLine += self.model.stops.filter({ $0.lines.contains(self.model.selectedBus.line) })
                    self.model.showBusInfo = true
                }
            }
        }
    }
    
    static func == (lhs: StopInfoView, rhs: StopInfoView) -> Bool {
        return lhs.stopInfo == rhs.stopInfo
    }
}
