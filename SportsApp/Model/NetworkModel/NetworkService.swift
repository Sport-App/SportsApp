//
//  NetworkService.swift
//  SportsApp
//
//  Created by Abanob Wadie on 23/04/2021.
//

import Foundation
import Alamofire

class NetworkService: DataSourceDelegate {
    
    var LeaguesDetails = [LeagueDetails]()
    var sportsName = String()
    var leagueName = String()
    var leagueId = String()
    
    func getSports(completion: @escaping ([Sport]?, Error?) -> ()) {
        AF.request(URLs.getSports).validate().responseDecodable(of: Sports.self) { (response) in
            
            switch response.result {
                case .success( _):
                        
                    guard let data = response.value else { return }
                    completion(data.sports, nil)
                    
                case .failure(let error):
                    
                    print(error)
                    completion(nil, error)
            }
        }
    }
    func getTeamById(id : String,completion: @escaping (Team?, Error?) -> ()) {
        AF.request(URLs.getTeamDetailsById+id).validate().responseDecodable(of: TeamList.self) { (response) in
            
            switch response.result {
                case .success( _):
                        
                    guard let data = response.value else { return }
                    completion(data.teams[0], nil)
                    
                case .failure(let error):
                    print(error)
                    completion(nil, error)
            }
        }
    }
    func getLeagues(completion: @escaping ([LeagueDetails]?, Error?) -> ()) {
        AF.request(URLs.getLeagues).validate().responseDecodable(of: LeagueList.self) { (response) in
            
            switch response.result {
                case .success( _):
                        
                    guard let data = response.value else { return }
                    
                    self.LeaguesDetails.removeAll()
                    for item in data.leagues {
                        if item.strSport == self.sportsName {
                            self.getLeagueDetailsById(leagueId: item.idLeague) { (leagueDetails, error) in
                                completion(leagueDetails, nil)
                            }
                        }
                    }
                    
                case .failure(let error):
                    
                    print(error)
                    completion(nil, error)
            }
        }
    }
    
    func getLeagueDetailsById(leagueId: String, completion: @escaping ([LeagueDetails]?, Error?) -> ()) {
        AF.request(URLs.getLeagueDetailsById + leagueId).validate().responseDecodable(of: LeagueDetailsList.self) { (response) in
            
            switch response.result {
                case .success( _):
                        
                    guard let data = response.value else { return }
                    self.LeaguesDetails.append(data.leagues[0])
                    completion(self.LeaguesDetails, nil)
                    
                case .failure(let error):
                    completion(nil, error)
                    print(error)
                    
            }
        }
    }
    
    func getLatestAndUpcomingEvents(completion: @escaping ([Event]?, [Event]?, Error?) -> ()) {
        AF.request(URLs.getLatestEvent(leagueId: leagueId)).validate().responseDecodable(of: EventsList.self) { (response) in
            
            switch response.result {
                case .success( _):
                        
                    guard let data = response.value else { return }
                    
                    let events = data.events
                    
                    guard let event = events else { return }
                    guard let round = event[0].intRound else { return }
                    
                    self.getUpcomingEvents(round: "\(Int(round)! + 1)", season: event[0].strSeason) { (upcomingEvent, error) in
                        if let error = error {
                            completion(events, nil, error)
                        }else {
                            completion(events, upcomingEvent, nil)
                        }
                    }
                    
                case .failure(let error):
                    
                    print(error)
                    completion(nil, nil, error)
            }
        }
    }
    
    func getUpcomingEvents(round: String, season: String, completion: @escaping ([Event]?, Error?) -> ()) {
        AF.request(URLs.getUpcomingEvent(leagueId: leagueId, round: round, season: season)).validate().responseDecodable(of: EventsList.self) { (response) in
            
            switch response.result {
                case .success( _):
                        
                    guard let data = response.value else { return }
                    
                    completion(data.events, nil)
                    
                case .failure(let error):
                    
                    print(error)
                    completion(nil, error)
            }
        }
    }
    
    func getTeams(completion: @escaping ([Teams]?, Error?) -> ()) {
        AF.request(URLs.getLeagueTeams(leagueName: leagueName)).validate().responseDecodable(of: TeamsList.self) { (response) in
            
            switch response.result {
                case .success( _):
                        
                    guard let data = response.value else { return }
                    
                    completion(data.teams, nil)
                    
                case .failure(let error):
                    
                    print(error)
                    completion(nil, error)
            }
        }
    }
}
