//
//  ContentView.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26
//

import SwiftUI
import SwiftData
import MapKit
internal import Combine


struct ContentView: View {
    @Environment(\.colorScheme)        private var colorScheme
    @Environment(MsBusRadarModel.self) private var model
    
    var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var position          : MapCameraPosition  = .region(MKCoordinateRegion(center: Constants.MAP_CENTER, span: Constants.MAP_SPAN))
    @State private var region            : MKCoordinateRegion = MKCoordinateRegion(center: Constants.MAP_CENTER, span: Constants.MAP_SPAN)
    @State private var bounds            : MapCameraBounds    = MapCameraBounds(centerCoordinateBounds: MKCoordinateRegion(center: Constants.MAP_CENTER, span: Constants.MAP_SPAN), minimumDistance: 100, maximumDistance: 35000)
    @State private var showLineSelection : Bool               = false
    @State private var showStopInfo      : Bool               = false    
    
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Constants.BLUE.edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .center) {
                        Text("Münster Bus Radar")
                            .foregroundStyle(.white)
                            .font(Constants.TITLE_FONT)
                        
                        HStack {
                            Button {
                                self.model.selectedStop          = Constants.DEFAULT_STOP
                                self.model.selectedBus           = Constants.DEFAULT_BUS
                                self.model.selectedParkingGarage = Constants.DEFAULT_PARKING_GARAGE
                                self.model.stopsOfSelectedLine.removeAll()
                            } label: {
                                Text("Selektion aufheben")
                                    .font(Constants.INFO_FONT)
                                    .foregroundStyle(colorScheme == .dark ? .white : Constants.DARK_BLUE)
                            }
                            .buttonStyle(.glass)
                            
                            if !self.model.networkMonitor.isConnected {
                                Spacer()
                                Text("OFFLINE")
                                    .font(.system(size: 8))
                                    .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                                    .foregroundStyle(.white)
                                    .background(
                                        ZStack {
                                            RoundedRectangle(
                                                cornerRadius: 5,
                                                style       : .continuous
                                            )
                                            .fill(.red)
                                            RoundedRectangle(
                                                cornerRadius: 5,
                                                style       : .continuous
                                            )
                                            .stroke(.red, lineWidth: 1)
                                        }
                                    )
                            }
                            
                            Spacer()
                            
                            Button {
                                self.position = .region(MKCoordinateRegion(center: self.model.locationManager?.location?.coordinate ?? Constants.MAP_CENTER, span: self.model.currentMapSpan))                                
                            } label: {
                                Image(systemName: "scope")
                                    .font(Constants.INFO_FONT)
                                    .foregroundStyle(colorScheme == .dark ? .white : Constants.DARK_BLUE)
                            }
                            .buttonStyle(.glass)
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                                
                        Map(position: self.$position, bounds: self.bounds, interactionModes: [.pan, .zoom]) {
                            // Draw stops
                            if self.model.showStops {
                                if self.model.stopsOfSelectedLine.isEmpty {
                                    ForEach(self.model.selectedStops) { stop in
                                        Annotation("", coordinate: stop.coordinate) {
                                            ZStack(alignment: .top) {
                                                let isSelectedStop = stop.id == self.model.selectedStop.id
                                                if isSelectedStop {
                                                    Image(systemName: "circle.fill")
                                                        .resizable()
                                                        .frame(width: 26, height: 26)
                                                        .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                        .foregroundStyle(Constants.SELECTION_COLOR)
                                                }
                                                
                                                Image(systemName: "h.circle.fill")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(Constants.STOP_GREEN, Constants.STOP_YELLOW)
                                                    .font(.system(size: 10, weight: .medium))
                                                    .opacity(0.75)
                                                    .offset(y: isSelectedStop ? 1 : 0)
                                                Image(systemName: "circle")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(Constants.STOP_GREEN)
                                                    .opacity(0.75)
                                                    .offset(y: isSelectedStop ? 1 : 0)
                                            }
                                            .onTapGesture {
                                                self.model.stopsOfSelectedLine.removeAll()
                                                self.model.selectedStop  = stop
                                                self.showStopInfo        = true
                                            }
                                        }
                                            .mapOverlayLevel(level: .aboveLabels)
                                    }
                                } else {
                                    ForEach(self.model.stopsOfSelectedLine) { stop in
                                        let isSelectedStop = stop.id == self.model.selectedStop.id
                                        Annotation("", coordinate: stop.coordinate) {
                                            ZStack(alignment: .top) {
                                                if isSelectedStop {
                                                    Image(systemName: "circle.fill")
                                                        .resizable()
                                                        .frame(width: 26, height: 26)
                                                        .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                        .foregroundStyle(Constants.SELECTION_COLOR)
                                                }
                                                
                                                Image(systemName: "h.circle.fill")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(Constants.STOP_GREEN, Constants.STOP_YELLOW)
                                                    .font(.system(size: 10, weight: .medium))
                                                    .opacity(0.75)
                                                    .offset(y: isSelectedStop ? 1 : 0)
                                                Image(systemName: "circle")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(Constants.STOP_GREEN)
                                                    .opacity(0.75)
                                                    .offset(y: isSelectedStop ? 1 : 0)
                                            }
                                            .onTapGesture {
                                                self.model.stopsOfSelectedLine.removeAll()
                                                self.model.selectedStop  = stop
                                                self.showStopInfo        = true
                                            }
                                        }
                                            .mapOverlayLevel(level: .aboveLabels)
                                    }
                                }
                            }

                            // Draw busses
                            let busColor : Color = colorScheme == .dark ? Constants.BLUE : Constants.DARK_BLUE
                            ForEach(self.model.busses) { bus in
                                if self.model.showFavoriteLines ? (self.model.favoriteLines.isEmpty ? Constants.ALL_LINES.contains(bus.line) : self.model.favoriteLines.contains(bus.line)) : Constants.ALL_LINES.contains(bus.line) {
                                    Annotation("", coordinate: bus.coordinate) {
                                        ZStack(alignment: .top) {
                                            let isSelectedBus = bus.id == self.model.selectedBus.id
                                            Image(systemName: "circle.fill")
                                                .resizable()
                                                .frame(width: 26, height: 26)
                                                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                .foregroundStyle(isSelectedBus ? Constants.SELECTION_COLOR : busColor)
                                                                                        
                                            Image(systemName: "bus.fill")
                                                .resizable()
                                                .foregroundStyle(.white)
                                                .frame(width: 16, height: 16)
                                                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                .offset(y: 5)
                                            
                                            Text(bus.line)
                                                .font(Constants.BUS_FONT)
                                                .padding(4)
                                                .cornerRadius(4)
                                                .offset(y: 22)
                                        }                                                                               
                                        .onTapGesture {
                                            self.model.selectedParkingGarage = Constants.DEFAULT_PARKING_GARAGE
                                            self.model.selectedBus           = bus
                                            self.model.stopsOfSelectedLine.removeAll()
                                            self.model.stopsOfSelectedLine += self.model.stops.filter({ $0.lines.contains(self.model.selectedBus.line) })
                                            self.model.showBusInfo = true
                                        }
                                    }
                                    .mapOverlayLevel(level: .aboveLabels)
                                }
                            }
                            
                            // Draw parking garages
                            ForEach(self.model.parkingGarages) { garage in
                                Annotation("", coordinate: garage.coordinate) {
                                    ZStack(alignment: .top) {
                                        if garage == self.model.selectedParkingGarage {
                                            Constants.SELECTION_COLOR
                                                .frame(width: 22, height: 22)
                                                .cornerRadius(10)
                                        } else {
                                            Color.white
                                                .frame(width: 22, height: 22)
                                                .cornerRadius(10)
                                        }
                                        Image(systemName: "parkingsign.square.fill")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                            .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                            .foregroundStyle(Constants.PARK_BLUE)
                                        Text(garage.name)
                                            .font(Constants.BUS_FONT)
                                            .padding(4)
                                            .cornerRadius(4)
                                            .offset(y: 20)
                                    }
                                    .onTapGesture {
                                        Task {
                                            if self.model.networkMonitor.isConnected {
                                                self.model.parkingGarages.removeAll()
                                                self.model.parkingGarages += await RestController.getGarageGarages()
                                            }
                                        }                                        
                                        self.model.selectedBus           = Constants.DEFAULT_BUS
                                        self.model.selectedParkingGarage = garage
                                    }
                                }
                            }
                            
                            // Draw train stations
                            Annotation("", coordinate: Constants.MAIN_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Münster Hbf"
                                        }
                                    Text("Münster Hbf")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            Annotation("", coordinate: Constants.NORTH_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Zentrum Nord"
                                        }
                                    Text("Zentrum Nord")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            Annotation("", coordinate: Constants.HILTRUP_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Hiltrup"
                                        }
                                    Text("Hiltrup")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            Annotation("", coordinate: Constants.AMELSBUEREN_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Amelsbüren"
                                        }
                                    Text("Amelsbüren")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            Annotation("", coordinate: Constants.ALBACHTEN_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Albachten"
                                        }
                                    Text("Albachten")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            Annotation("", coordinate: Constants.MECKLENBECK_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Mecklenbeck"
                                        }
                                    Text("Mecklenbeck")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            Annotation("", coordinate: Constants.SPRAKEL_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Sprakel"
                                        }
                                    Text("Sprakel")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            Annotation("", coordinate: Constants.ROXEL_STATION_COORDS) {
                                ZStack {
                                    Image("DB")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            self.model.showStationData.toggle()
                                            self.model.selectedTrainstation = "Roxel"
                                        }
                                    Text("Roxel")
                                        .font(Constants.BUS_FONT)
                                        .padding(4)
                                        .cornerRadius(4)
                                        .offset(y: 20)
                                }
                            }
                            
                            // Draw current user location
                            UserAnnotation()
                        }
                        .mapStyle(.standard(pointsOfInterest: .including([.publicTransport]), showsTraffic: true))
                        .frame(height: geo.size.height * 0.68)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .cornerRadius(10)
                        .onMapCameraChange { mapCameraUpdateContext in
                            self.model.currentMapSpan = mapCameraUpdateContext.region.span                            
                        }
                        
                        if self.model.showBusInfo && self.model.selectedBus.id != "none" {
                            let bus : Bus = self.model.selectedBus
                            VStack(spacing: 4) {
                                HStack {
                                    Button {
                                        self.position = .region(MKCoordinateRegion(center: self.model.selectedBusLocation, span: self.model.currentMapSpan))
                                    } label: {
                                        Image(systemName: "scope")
                                            .font(Constants.INFO_FONT)
                                            .foregroundStyle(.white)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "bus.fill")
                                        .font(Constants.LINE_NR_FONT)
                                        .foregroundStyle(.white)
                                    Text("Linie \(bus.line)")
                                        .font(Constants.LINE_NR_FONT)
                                        .foregroundStyle(.white)
                                    if self.model.selectedBusLastUpdate != "" {
                                        Text(" (\(self.model.selectedBusLastUpdate))")
                                            .font(Constants.BUS_INFO_FONT)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                                
                                Text("Richtung \(bus.direction)")
                                    .font(Constants.BUS_INFO_FONT)
                                    .foregroundStyle(.white)
                                
                                Text("\(bus.delay < 60 ? "Pünktlich" : "\(bus.delay / 60) min Verspätung")")
                                    .font(Constants.BUS_INFO_FONT)
                                    .foregroundStyle(.white)
                                                            
                                if self.model.nextStop.id != "none" {
                                    Text("Nächste Haltestelle: \(self.model.nextStop.name)")
                                        .font(Constants.BUS_INFO_FONT)
                                        .foregroundStyle(.white)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                            .cornerRadius(10)
                            .background(Constants.DARK_BLUE.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else if self.model.selectedParkingGarage.name != "none" {
                            let garage : ParkingGarage = self.model.selectedParkingGarage
                            VStack(spacing: 4) {
                                HStack {
                                    Spacer()
                                    
                                    ZStack(alignment: .top) {
                                        Color.white
                                            .frame(width: 26, height: 26)
                                            .cornerRadius(10)
                                        Image(systemName: "parkingsign.square.fill")
                                            .resizable()
                                            .frame(width: 26, height: 26)
                                            .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                            .foregroundStyle(Constants.PARK_BLUE)
                                    }
                                    
                                    Text("\(garage.name)")
                                        .font(Constants.LINE_NR_FONT)
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                                
                                
                                Text("\(garage.state.uiString())")
                                    .font(Constants.BUS_INFO_FONT)
                                    .foregroundStyle(garage.state == .frei ? Constants.PARK_GREEN : .red)
                                
                                Text("Stand \(garage.lastUpdate)")
                                    .font(Constants.BUS_INFO_FONT)
                                    .foregroundStyle(.white)
                                
                                Text("\(garage.freeSpaces) Plätze frei von \(garage.totalSpaces)")
                                    .font(Constants.BUS_INFO_FONT)
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                            .cornerRadius(10)
                            .background(Constants.DARK_BLUE.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Spacer()
                    }
                    .padding(10)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        VStack(alignment: .center) {
                            Text("Haltestellen")
                                .font(Constants.TOOLBAR_FONT)
                            
                            HStack {
                                Button {
                                    self.model.showStops.toggle()
                                } label: {
                                    ZStack {
                                        if self.model.showStops {
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
                                        } else {
                                            Image(systemName: "h.circle.fill")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.black, .white)
                                            Image(systemName: "circle")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .shadow(color: .clear, radius: 0, x: 0, y: 0)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                                .buttonStyle(.glass)
                                
                                Button {
                                    self.model.showFavoriteStops.toggle()
                                } label: {
                                    if self.model.showFavoriteStops {
                                        Image(systemName: "star.fill")
                                    } else {
                                        Image(systemName: "star")
                                    }
                                }
                                .buttonStyle(.glass)
                                .disabled(!self.model.showStops)
                            }
                        }
                        
                        Divider()
                            .frame(width: 2, height: 32)
                            .overlay(.white)
                        
                        VStack(alignment: .center) {
                            Text("Buslinien")
                                .font(Constants.TOOLBAR_FONT)
                            
                            HStack {
                                Button {
                                    self.showLineSelection.toggle()
                                } label: {
                                    Image(systemName: "bus")
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(.glass)
                                
                                Button {
                                    self.model.showFavoriteLines.toggle()
                                } label: {
                                    if self.model.showFavoriteLines {
                                        Image(systemName: "star.fill")
                                    } else {
                                        Image(systemName: "star")
                                    }
                                }
                                .buttonStyle(.glass)
                            }
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .onAppear {
            self.model.checkIfLocationIsEnabled()
        }
        .task {
            self.position = .region(MKCoordinateRegion(center: self.model.getUserLocation() ?? Constants.MAP_CENTER, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            if self.model.networkMonitor.isConnected {
                self.model.stops.removeAll()
                self.model.stops += await RestController.getStops()
                
                self.model.stopLines.keys.forEach { key in
                    let stop : Stop? = self.model.stops.filter({ $0.globalId == key }).first
                    if stop != nil {
                        self.model.stopLines[key]?.forEach { line in
                            stop!.lines.append(line)
                        }
                    }
                }
                
                self.model.busses.removeAll()
                self.model.busses += await RestController.getBusses()
                
                if self.model.showStops {
                    self.model.selectedStops.removeAll()
                    if self.model.showFavoriteStops && !self.model.favoriteStops.isEmpty {
                        self.model.stops.forEach { stop in
                            if self.model.favoriteStops.contains(stop.globalId) {
                                self.model.selectedStops.append(stop)
                            }
                        }
                    } else {
                        self.model.selectedStops += self.model.stops
                    }
                } else {
                    self.model.selectedStops.removeAll()
                }
                
                self.model.parkingGarages.removeAll()
                self.model.parkingGarages += await RestController.getGarageGarages()
            }
        }
        .onReceive(timer) {_ in 
            Task {
                if self.model.networkMonitor.isConnected {
                    let busses : [Bus] = await RestController.getBusses()
                    self.model.busses.removeAll()
                    self.model.busses += busses
                }
                
                if self.model.selectedBus.id != "none" {
                    let bus        : Bus    = self.model.busses.first(where: { $0.id == self.model.selectedBus.id }) ?? Constants.DEFAULT_BUS
                    let nextStopId : String = bus.nextStopId
                    self.model.nextStop = self.model.stops.first(where: { $0.id.starts(with: nextStopId) }) ?? Constants.DEFAULT_STOP
                }
            }
        }
        .sheet(isPresented: self.$showStopInfo) {
            if self.model.selectedStop.id != "none" {
                StopInfoOverview(stop: self.model.selectedStop)
                    .presentationDetents([.medium])
                    .onDisappear {
                        self.model.selectedStop = Constants.DEFAULT_STOP
                    }
            }
        }
        .sheet(isPresented: self.$showLineSelection) {
            LineSelectionView()
                .presentationDetents([.medium])
        }
        .sheet(isPresented: self.model.showStationDataBinding) {
            StationDataView()
        }
    }
}
