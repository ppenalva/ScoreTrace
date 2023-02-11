//
//  ScoreTraceApp.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/8/23.
//

import SwiftUI

@main
struct ScoreTrackApp: App {
  
    @StateObject private var storeMatch = MatchStore()
   
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MatchesView(matches: $storeMatch.matches) {
                    MatchStore.save(matches: storeMatch.matches) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                MatchStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let matches):
                        storeMatch.matches = matches
                    }
                }
            }
        }
    }
}
