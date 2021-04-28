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
        AF.request(URLs.getTeamDetailsById+id).validate().responseDecodable(of: Teams.self) { (response) in
            
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
}
