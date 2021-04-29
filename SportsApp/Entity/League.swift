//
//  League.swift
//  SportsApp
//
//  Created by Abanob Wadie on 21/04/2021.
//

import Foundation

class LeagueList: Codable {
    var leagues: [League]
}

class League: Codable {
    var idLeague: String
    var strLeague: String?
    var strSport: String?
    var strLeagueAlternate: String?
}


class LeagueDetailsList: Codable {
    var leagues: [LeagueDetails]
}


class LeagueDetails: Codable {
    var idLeague: String
    var strYoutube: String?
    var strBadge: String?
    var strLeague: String?
}

