//
//  Event.swift
//  SportsApp
//
//  Created by Abanob Wadie on 28/04/2021.
//

import Foundation

class EventsList: Codable {
    var events: [Event]
}

class Event: Codable {
    var idEvent: String
    var strSeason: String
    var strHomeTeam: String
    var strAwayTeam: String
    var intHomeScore: String?
    var intRound: String
    var intAwayScore: String?
    var idHomeTeam: String
    var idAwayTeam: String
    var dateEvent: String
}

