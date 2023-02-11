//
//  MatchView.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/9/23.
//

import SwiftUI

struct MatchView: View {
    
    @Binding var match: Match
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(match.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(match.players.count)", systemImage: "person.3")
                    .padding(.trailing, 20)
                Spacer()
                Label("\(match.rounds.count)", systemImage: "r.circle")
                
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(match.theme.accentColor)
    }
}
