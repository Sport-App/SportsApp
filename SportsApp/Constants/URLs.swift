//
//  URLs.swift
//  SportsApp
//
//  Created by Abanob Wadie on 21/04/2021.
//

import Foundation

class URLs {
    private static let baseUrl = "https://www.thesportsdb.com/api/v1/json/1/"
    
    static let getSports = baseUrl + "all_sports.php"
    static let getLeagues = baseUrl + "all_leagues.php"
    static let getLeagueDetailsById = baseUrl + "lookupleague.php?id="
    static let getTeamDetailsById = baseUrl + "lookupteam.php?id="

}

