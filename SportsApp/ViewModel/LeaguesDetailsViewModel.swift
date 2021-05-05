//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Abanob Wadie on 28/04/2021.
//

import Foundation

class LeaguesDetailsViewModel {
    let factory = FactoryService()
    var networkService = NetworkService()
    var offlineService: OfflineService!
    
    init(leagueName: String, leagueId: String, appDelegate: AppDelegate) {
        offlineService = OfflineService(appDelegate: appDelegate)
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
    
    var teams: [Teams]! {
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
            }
            
            if let latestEvent = latestEvent {
                self.latestEvent = latestEvent
            }
                
            if let upcomingEvent = upcomingEvent {
                self.upcomingEvent = upcomingEvent
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
    
    func addLeague(league: LeagueDetails) {
        offlineService.add(league: league)
    }
    
    func deleteLeague(leagueName: String) {
        offlineService.delete(name: leagueName)
    }
    
    func isFav(leaguesName: String) -> Bool {
        return offlineService.isExist(name: leaguesName)
    }
}
