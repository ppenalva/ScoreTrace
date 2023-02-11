//
//  DetailEditView.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/9/23.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding var dataMatch: Match.Data
    
    @Binding var match : Match
    
    @State private var newPlayerName = ""
    
    @State private var newMatchData = Match.Data()
    
    @State private var newRoundData = Match.Round.Data()
    @State private var newRoundPointData = Match.Round.Point.Data()
    @State private var  newRoundPointsData = [Match.Round.Point.Data()]
    
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Match Info")) {
                    TextField("Name", text: $dataMatch.name)
                        .disabled(match.rounds.count != 0)
                    ThemePicker(selection: $dataMatch.theme)
                }
                
                Section(header: Text("Players"))
                {
                    ForEach(dataMatch.players) { player in
                        Text(player.name)
                    }
                    .onMove (perform: movePlayers)
                    .onDelete { indices in
                        dataMatch.players.remove(atOffsets: indices)
                    }
                    HStack {
                        TextField("New Player", text: $newPlayerName)
                        Button(action: {
                            withAnimation {
                                let player = Match.Player(name: newPlayerName)
                                dataMatch.players.append(player)
                                newPlayerName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newPlayerName.isEmpty)
                    }
                }
                Section(header: Text("Rounds"))
                {
                    ForEach ($dataMatch.rounds) { $round in
                        NavigationLink(destination: RoundDetailView( round: $round ))
                        {
                            Text(round.name)
                        }
                        .isDetailLink(false)
                    }
                    .onMove (perform: moveRounds)
                    .onDelete { indices in
                        dataMatch.rounds.remove(atOffsets: indices)
                    }
                }
            }
            .toolbar {
                EditButton ()
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    func movePlayers(from source: IndexSet, to destination: Int) {
        dataMatch.players.move(fromOffsets: source, toOffset: destination)
    }
    func moveRounds(from source: IndexSet, to destination: Int) {
        dataMatch.rounds.move(fromOffsets: source, toOffset: destination)
    }
}
