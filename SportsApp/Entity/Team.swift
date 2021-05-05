//
//  Team.swift
//  SportsApp
//
//  Created by Abanob Wadie on 28/04/2021.
//

import Foundation

class TeamsList: Codable {
    var teams: [Teams]
}

class Teams: Codable {
    var idTeam: String
    var strTeam: String
    var strTeamBadge: String?
}
