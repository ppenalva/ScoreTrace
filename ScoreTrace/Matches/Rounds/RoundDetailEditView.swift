//
//  RoundDetailEditView.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/9/23.
//

import SwiftUI

struct RoundDetailEditView: View {
    
    @Binding var round: Match.Round.Data
    
    var body: some View {
        
        List {
            Section(header: Text("Round Name")) {
                TextField("Round Name", text: $round.name)
            }
            Section(header: Text("Points")) {
                ForEach($round.points) { $point in
                    HStack {
                        Text(point.name)
                        Spacer()
                        TextField("", value: $point.value, format: .number)
                    }
                }
            }
        }
    }
}
