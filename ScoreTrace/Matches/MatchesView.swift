//
//  MatchesView.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/9/23.
//

import SwiftUI

struct MatchesView: View {
    
    @Binding var matches: [Match]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingNewMatchView = false
    
    @State private var newMatchData = Match.Data()
    
    @State var match: Match = Match(data: Match.Data())
    
    
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($matches) { $match1 in
                NavigationLink(destination: DetailView(match: $match1))
                { MatchView(match: $match1)}
                    .isDetailLink(false)
                    .listRowBackground(match1.theme.mainColor)
            }
            .onDelete { indices in
                matches.remove(atOffsets: indices)
            }
            .onMove (perform: move)
        }
        .navigationTitle("Matches")
        .toolbar {
            Button(action: {
                newMatchData = Match.Data()
                isPresentingNewMatchView = true}) {
                    Image(systemName: "plus")
                }
        }
        .sheet(isPresented: $isPresentingNewMatchView) {
            NavigationView {
                DetailEditView( dataMatch: $newMatchData, match: $match)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewMatchView = false
                                newMatchData = Match.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newMatch = Match(data: newMatchData)
                                matches.append(newMatch)
                                isPresentingNewMatchView = false
                                newMatchData = Match.Data()
                            }
                        }
                    }
            }
            
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
        func move(from source: IndexSet, to destination: Int) {
            matches.move(fromOffsets: source, toOffset: destination)
    }
}
