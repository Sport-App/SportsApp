//
//  Teams.swift
//  SportsApp
//
//  Created by ahmed on 4/28/21.
//

import Foundation
class Teams: Codable {
    
    var teams : [Team]
        
    enum CodingKeys : String , CodingKey {
        case teams = "teams"
    }
    
}

class Team: Codable {
        
    var name : String
    var stadium : String
    var country : String
    var league : String
    var imageMain : String
    var imageSecond : String
    var description : String
    var youtube : String?
    var fb : String?
    var tw : String?
    enum CodingKeys : String , CodingKey {
        case name = "strTeam"
        case league = "strLeague"
        case description = "strDescriptionEN"
        case stadium = "strStadium"
        case imageMain = "strStadiumThumb"
        case imageSecond = "strTeamBadge"
        case country = "strCountry"
        case youtube = "strYoutube"
        case fb = "strFacebook"
        case tw = "strTwitter"

    }
}
