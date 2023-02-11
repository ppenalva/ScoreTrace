//
//  DetailView.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/9/23.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var match: Match
    
    @State private var dataMatch = Match.Data()
    
    @State private var isPresentingNewRound = false
    
    @State private var isPresentingEditView = false
    
    @State private var newRoundData = Match.Round.Data()
    @State private var newRoundPointData = Match.Round.Point.Data()
    
    func calculatePlayerScore(player: String) -> Double {
        var total = 0.0
        for (round) in match.rounds {
            for point in round.points {
                if (point.name == player)
                {
                    total += point.value
                }
            }
        }
        return total
    }
    
    var body: some View {
        
        List {
            Section(header: Text(" Match Info")) {
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Text(match.theme.name)
                        .padding(4)
                        .foregroundColor(match.theme.accentColor)
                        .background(match.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            Button("New Round") {
                
                newRoundData = Match.Round.Data()
                
                let maxRoundName = match.rounds.max()?.name
                let number =  Int(maxRoundName?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() ?? "00")
                let newNumber = number! + 1
                let texto = maxRoundName?.components(separatedBy: CharacterSet.decimalDigits).joined()
                let newRoundName = (texto ?? "Round ") + String(newNumber)
                
                
                newRoundData.name = newRoundName
                
                for player in match.players {
                    newRoundPointData.name = player.name
                    newRoundPointData.value = 0.0
                    let newPoint = Match.Round.Point(data: newRoundPointData)
                    newRoundData.points.append(newPoint)
                }
                
                isPresentingNewRound = true
            }
            
            Section(header: Text("Players")) {
                ForEach(match.players) { player in
                    HStack {
                        Label(player.name, systemImage: "person")
                        Spacer()
                        let total1 = calculatePlayerScore(player: player.name)
                        Text(String(format: "%.2f",total1))
                    }
                }
            }
            
            Section(header: Text("Rounds")) {
                ForEach($match.rounds) { $round in
                    NavigationLink(destination: RoundDetailView(round: $round)) {
                        Text(round.name)
                    }
                    .isDetailLink(false)
                }
            }
        }
        .navigationTitle(match.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                dataMatch = match.data
            }
        }
        .sheet(isPresented: $isPresentingNewRound) {
            NavigationView {
                RoundDetailEditView( round: $newRoundData)
                    .navigationTitle(match.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                
                                isPresentingNewRound = false
                                //                              newRoundData = Match.Round.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                let newRound = Match.Round(data: newRoundData)
                                match.rounds.insert(newRound, at: 0)
                                isPresentingNewRound = false
                                //                              newRoundData = Match.Round.Data()
                            }
                        }
                    }
            }
        }
        
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView (dataMatch: $dataMatch, match: $match)
                    .navigationTitle(match.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                match.update(from:  dataMatch)
                                isPresentingEditView = false
                            }
                        }
                    }
            }
            .navigationTitle(match.name)
        }
    }
}
