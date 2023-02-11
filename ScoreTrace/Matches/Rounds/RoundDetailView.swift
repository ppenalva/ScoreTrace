//
//  RoundDetailView.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/9/23.
//

import SwiftUI

struct RoundDetailView: View {
    
    @Binding var round : Match.Round
    
    @State private var dataRound = Match.Round.Data()
    
    @State private var isPresentingRoundEditView = false
    
    var body: some View {
        
        List {
            ForEach(round.points) { point in
                HStack {
                    Text("\(point.name)")
                    Spacer()
                    Text(String(format: "%.2f",point.value))
                }
            }
            
        }
        .navigationTitle(round.name)
        .toolbar {
            Button("Edit") {
                isPresentingRoundEditView = true
                dataRound = round.data
            }
        }
        .sheet(isPresented: $isPresentingRoundEditView) {
            NavigationView {
                RoundDetailEditView (round: $dataRound)
                
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingRoundEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                round.update(from:  dataRound)
                                isPresentingRoundEditView = false
                            }
                        }
                        
                    }
                
            }
            
            .navigationTitle(round.name)
        }
        
    }
}

