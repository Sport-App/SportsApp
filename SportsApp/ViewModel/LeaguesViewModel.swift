//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Abanob Wadie on 23/04/2021.
//

import Foundation

class LeaguesViewModel {
    
    let factory = FactoryService()
    var dataSourceDelegate: DataSourceDelegate!
    var sportsName = String()
    
    
    init(sportsName: String , type : ViewType , appDelegate:AppDelegate) {
        self.sportsName = sportsName
        dataSourceDelegate = factory.build(type: type, appDelegate: appDelegate)
        dataSourceDelegate.sportsName = sportsName
    }
    
    var Leagues = [LeagueDetails]() {
        didSet{
            bindLeaguestoView()
        }
    }
    
    var error: String! {
        didSet{
            bindErrortoView()
        }
    }
    
    var bindLeaguestoView: () -> () = {}
    var bindErrortoView: () -> () = {}
    
    func getLeagues() {
        dataSourceDelegate.getLeagues { (leagueDetails, error) in
            
            if let error = error {
                self.error = error.localizedDescription
            }else{
                self.Leagues = leagueDetails!
            }
            
        }
    }
}
