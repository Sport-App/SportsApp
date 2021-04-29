//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Abanob Wadie on 28/04/2021.
//

import Foundation

class LeaguesDetailsViewModel {
    let factory = FactoryService()
    var networkService: NetworkService!
    
    init(leagueName: String, leagueId: String) {
        networkService.leagueName = leagueName
        networkService.leagueId = leagueId
    }
    
    var latestEvent: [Event]! {
        didSet{
            bindlatestEventToView()
        }
    }
    
    var upcomingEvent: [Event]! {
        didSet{
            bindupcomingEventToView()
        }
    }
    
    var teams: [Team]! {
        didSet{
            bindTeamsToView()
        }
    }
    
    var error: String! {
        didSet{
            bindErrortoView()
        }
    }
    
    var bindlatestEventToView: () -> () = {}
    var bindupcomingEventToView: () -> () = {}
    var bindTeamsToView: () -> () = {}
    var bindErrortoView: () -> () = {}
    
    func getEvents() {
        networkService.getLatestAndUpcomingEvents { (latestEvent, upcomingEvent, error) in
            if let error = error {
                self.error = error.localizedDescription
            }else{
                self.latestEvent = latestEvent!
                self.upcomingEvent = upcomingEvent!
            }
        }
    }
    
    func getTeams() {
        networkService.getTeams { (teams, error) in
            if let error = error {
                self.error = error.localizedDescription
            }else{
                self.teams = teams!
            }
        }
    }
}
