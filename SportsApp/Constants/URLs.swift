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
    
    static func getLatestEvent(leagueId: String) -> String {
        return baseUrl + "eventspastleague.php?id=\(leagueId)"
    }
    static func getLeagueTeams(leagueName: String) -> String {
        return baseUrl + "search_all_teams.php?l=\(leagueName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    static func getUpcomingEvent(leagueId: String, round: String, season: String) -> String {
        return baseUrl + "eventsround.php?id=\(leagueId)&r=\(round)&s=\(season)"
    }
}

