//
//  LineSelectionView.swift
//  MsBusRadar
//
//  Created by Gerrit Grunwald on 20.07.26.
//

import SwiftUI

struct LineSelectionView: View {
    @Environment(\.colorScheme)        private var colorScheme
    @Environment(MsBusRadarModel.self) private var model
    @Environment(\.dismiss)            private var dismiss
        
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
                }
                .buttonStyle(.glass)
                .padding()
                
                List(Constants.ALL_LINES, id: \.self) { lineId in
                    let isFavorite : Bool = self.model.favoriteLines.contains(lineId)
                    HStack {
                        Text("Linie " + lineId)
                            .font(Constants.INFO_FONT)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .font(Constants.INFO_FONT)
                            .foregroundStyle(.white)
                            .onTapGesture {
                                if isFavorite {
                                    self.model.favoriteLines.removeAll(where: { $0 == lineId })
                                } else {
                                    self.model.favoriteLines.append(lineId)
                                }
                            }
                    }
                    .padding()
                    .listRowBackground(Constants.BLUE)
                }
                .background(Constants.BLUE)
                .listStyle(.plain)
                .selectionDisabled()
            }
        }
    }
}
