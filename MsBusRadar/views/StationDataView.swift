//
//  MainStationDataView.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 28.07.26.
//

import SwiftUI

struct StationDataView: View {
    @Environment(\.colorScheme)        private var colorScheme
    @Environment(MsBusRadarModel.self) private var model
    @Environment(\.dismiss)            private var dismiss
    
    @State private var station    : Station? {
        didSet {
            if self.station == nil { return }
            self.departures.removeAll()
            if self.station!.departures == nil { return }
            self.station!.departures!.forEach { departure in
                self.departures.append(departure)
            }
        }
    }
    @State private var departures : [Departures] = []
    
    let timeFormatter : DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Constants.BLUE
                .ignoresSafeArea(edges: .all)
            
            VStack {
                HStack(spacing: 10) {
                    Button {
                        Task {
                            await refreshTimetable()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                            .font(Constants.INFO_FONT)
                            .foregroundStyle(colorScheme == .dark ? .white : Constants.DARK_BLUE)
                    }
                    .buttonStyle(.glass)
                    
                    Spacer()
                                                            
                    Button("Schliessen") {
                        dismiss()
                    }
                    .buttonStyle(.glass)
                }
                .buttonStyle(.glass)
                .padding()
                
                Text(self.model.selectedTrainstation)
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                
                List(self.departures, id: \.self) { departure in
                    HStack(alignment: .center, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("\(departure.train ?? departure.trainNumber ?? "")")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)) // Add padding around the text
                                .background(Material.regular, in: RoundedRectangle(cornerRadius: 5))
                                .background(departure.train!.starts(with: "IC") ? .red : .clear)
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(departure.train!.starts(with: "IC") ? .red : .gray, lineWidth: 1))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Text("Gleis \(departure.platform ?? "")")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .frame(width: 80)
                        if departure.scheduledDeparture == nil {
                            // Arrival
                            VStack {
                                let isCancelled: Bool = departure.isCancelled ?? 0 == 1
                                Text("von \(departure.route?.first?.name ?? "")")
                                    .font(.system(size: 13, weight: .regular, design: .rounded))
                                    .foregroundStyle(.black.opacity(0.65))
                                    .strikethrough(isCancelled)
                                if isCancelled {
                                    Text("(Zug entfällt !)")
                                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                                        .foregroundStyle(Constants.DELAY_RED)
                                } else {
                                    Text("(Zug ended hier)")
                                        .font(.system(size: 10, weight: .regular, design: .rounded))
                                        .foregroundStyle(.black.opacity(0.65))
                                }
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 5) {
                                HStack {
                                    Text("\(departure.scheduledArrival ?? "")")
                                        .font(.system(size: 13, weight: .regular, design: .rounded))
                                        .foregroundStyle(.white)
                                    if (departure.delayArrival ?? 0 > 0) {
                                        Text("+\(String(departure.delayArrival ?? 0))")
                                            .font(.system(size: 13, weight: .regular, design: .rounded))
                                            .foregroundStyle(.white)
                                    }
                                }
                                if departure.delayArrival ?? 0 > 0 {
                                    let arrivalTime        : Date = self.timeFormatter.date(from: "\(departure.scheduledArrival!)")!
                                    let delayedArrivalTime : Date = arrivalTime.addingTimeInterval(TimeInterval(departure.delayArrival! * 60))
                                    Text("\(timeFormatter.string(from: delayedArrivalTime))")
                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                                        .foregroundStyle(Constants.DELAY_RED)
                                }
                            }
                        } else {
                            // Departure
                            VStack {
                                let isCancelled: Bool = departure.isCancelled ?? 0 == 1
                                Text("\(departure.route?.last?.name ?? "")")
                                    .font(.system(size: 13, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .strikethrough(isCancelled)
                                if isCancelled {
                                    Text("(Zug entfällt !)")
                                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                                        .foregroundStyle(Constants.DELAY_RED)
                                } else {
                                    EmptyView()
                                }
                                
                            }
                            Spacer()
                            
                            VStack(spacing: 5) {
                                HStack {
                                    Text("\(departure.scheduledDeparture ?? "")")
                                        .font(.system(size: 13, weight: .regular, design: .rounded))
                                        .foregroundStyle(.white)
                                    if departure.delayDeparture ?? 0 > 0 {
                                        Text("+\(String(departure.delayDeparture ?? 0))")
                                            .font(.system(size: 13, weight: .regular, design: .rounded))
                                            .foregroundStyle(.white)
                                    }
                                }
                                if departure.delayDeparture ?? 0 > 0 {
                                    let departureTime        : Date = self.timeFormatter.date(from: "\(departure.scheduledDeparture!)")!
                                    let delayedDepartureTime : Date = departureTime.addingTimeInterval(TimeInterval(departure.delayDeparture! * 60))
                                    Text("\(timeFormatter.string(from: delayedDepartureTime))")
                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                                        .foregroundStyle(Constants.DELAY_RED)
                                }
                            }
                        }
                    }
                    .listRowBackground(Constants.BLUE)
                }
                .background(Constants.BLUE)
                .listStyle(.plain)
                .selectionDisabled()
                
                Spacer()
            }
        }
        .task {
            self.station = await RestController.getStationInfo(stationUrl: Constants.STATIONS[self.model.selectedTrainstation]!)
        }
    }
    
    private func refreshTimetable() async -> Void {
        Task {
            self.station = await RestController.getStationInfo(stationUrl: Constants.STATIONS[self.model.selectedTrainstation]!)
        }
    }
}
