//
//  Match.swift
//  ScoreTrace
//
//  Created by Pablo Penalva on 2/8/23.
//

import Foundation

struct Match: Identifiable, Codable {
    let id: UUID
    var name: String
    var players: [Player]
    var theme: Theme
    var rounds: [Round]
    
    
    init(id: UUID = UUID(), name: String, players: [String], theme: Theme, rounds: [Round]) {
        self.id = id
        self.name = name
        self.players = players.map { Player(name: $0)}
        self.theme = theme
        self.rounds = rounds.map {Round( name: $0.name, points: $0.points.map{Match.Round.Point(name: $0.name, value: $0.value)})
            
        }
    }
}
extension Match {
    struct Data {
        var name: String = ""
        var players: [Match.Player] = []
        var theme: Theme = .seafoam
        var rounds: [Match.Round] = []
    }
    
    var data: Data {
        Data(name: name, players: players, theme: theme, rounds: rounds)
    }
    
    mutating func update(from data: Data) {
        name = data.name
        players = data.players
        theme = data.theme
        rounds = data.rounds
    }
    
    init(data: Data) {
        id = UUID()
        name = data.name
        players = data.players
        theme = data.theme
        rounds = data.rounds
    }
}


extension Match {
    static let sampleData: [Match] =
    [
        Match( name:"Partida 1",
               players:["Pablo","Rafael","Alberto"],
               theme: .yellow,
               rounds:[Match.Round(name: "ronda1", points: [Match.Round.Point(name: "Pablo", value: 3.0),Match.Round.Point(name: "Rafael", value: 4.0),Match.Round.Point(name: "Alberto", value: 3.0)])]),
        Match( name:"Partida 2",
               players:["Juan","Jose"],
               theme: .orange,
               rounds:[Match.Round(name: "ronda1", points: [Match.Round.Point(name: "Juan", value: 3.0),Match.Round.Point(name: "Jose", value: 4.0)])])
    ]
}


extension Match {
    struct Player: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id : UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
}

extension Match {
    struct Round: Identifiable, Codable, Comparable {
        
        let id: UUID
        var name: String
        var points: [Point]
        
        init(id : UUID = UUID(), name: String, points: [Point] ) {
            self.id = id
            self.name = name
            self.points = points.map { Point(name: $0.name, value: $0.value)}
        }
        static func < (lhs: Round, rhs: Round) -> Bool {
            lhs.name < rhs.name
        }
        
        
        static func == (lhs: Round, rhs: Round) -> Bool {
            lhs.name == rhs.name
        }
    }
}

extension Match.Round {
    struct Data {
        var name: String = ""
        var points: [Match.Round.Point] = []
    }
    var data: Data {
        Data(
            name: name,
            points: points
        )
    }
    mutating func update( from data: Data) {
        name = data.name
        points = data.points
    }
    init(data: Data) {
        id = UUID()
        name = data.name
        points = data.points
    }
}

extension Match.Round {
    struct Point: Identifiable, Codable {
        
        let id: UUID
        var name: String
        var value: Double
        
        init(id : UUID = UUID(), name: String, value: Double ) {
            self.id = id
            self.name = name
            self.value = value
        }
    }
}
extension Match.Round.Point {
    struct Data {
        var name: String = ""
        var value: Double = 0.0
    }
    var data: Data {
        Data(
            name: name,
            value: value
        )
    }
    mutating func update( from data: Data) {
        name = data.name
        value = data.value
    }
    init(data: Data) {
        id = UUID()
        name = data.name
        value = data.value
    }
}

